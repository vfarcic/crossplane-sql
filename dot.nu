#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu
source scripts/external-secrets.nu
source scripts/atlas.nu
source scripts/ingress.nu
source scripts/common.nu
source scripts/cnpg.nu
source scripts/aso.nu
source scripts/cert-manager.nu

def main [] {}

def --env "main setup" [
    --apply_irsa = false
    --apply_azure_creds = false
    --provider: string = ""
    --skip_ingress = false
] {

    let date_start = (date now)

    rm --force .env

    mut cluster = "kind"

    main create kubernetes $cluster

    main apply certmanager

    if not $skip_ingress {
        main apply ingress nginx --provider kind
    }

    main apply crossplane
    let provider_files = [
        "aws.yaml"
        "azure.yaml"
        "cluster-role.yaml"
        "function-auto-ready.yaml"
        "function-kcl.yaml"
        "function-status-transformer.yaml"
        "google.yaml"
        "provider-kubernetes-incluster.yaml"
        "sql.yaml"
        "upcloud.yaml"
    ]  
    for file in $provider_files {
        kubectl apply --filename $"providers/($file)"
    }
    kubectl apply --filename package/definition.yaml
    sleep 1sec
    kubectl apply --filename "package/compositions.yaml"
    let wait_result = (do {
        (
            kubectl wait
                --for=condition=healthy provider.pkg.crossplane.io
                --all --timeout 900s
        )
    } | complete)
    if $wait_result.exit_code != 0 {
        print "Providers failed to become healthy. Checking package revisions..."
        kubectl get pkgrev
        kubectl get providers
        error make {msg: "Providers failed to become healthy"}
    }
    if $provider == "aws" {
        setup aws
    } else if $provider == "azure" {
        setup azure
    } else if $provider == "google" {
        setup google
    } else if $provider == "upcloud" {
        setup upcloud
    }
    if $provider != "" {
        apply providerconfig $provider 
    }

    main apply external_secrets

    main apply atlas

    main apply cnpg

    (
        main apply aso --apply_creds $apply_azure_creds
            --namespace a-team
    )

    kubectl create namespace a-team

    let name = $"my-db-(date now | format date "%Y%m%d%H%M%S")"
    $"export DB_NAME=($name)\n" | save --append .env

    open examples/azure-aso-secret.yaml
        | upsert metadata.name $"($name)-password"
        | save examples/azure-aso-secret.yaml --force

    open examples/azure-aso.yaml
        | upsert metadata.name $name
        | save examples/azure-aso.yaml --force

    print $"Finished in ((date now) - $date_start)"

    main print source
    
}

def --env "main package apply" [] {

    crossplane compositions generate

    kubectl apply --filename package/definition.yaml
    
    sleep 1sec

    kubectl apply --filename package/compositions.yaml

}

def --env "main test full" [] {

    main setup --skip_ingress true

    main package apply

    # FIXME: "cnpg"
    let dirs = [
        "aws"
        "azure"
        "azure-aso"
        "google"
        "upcloud"
    ]  
    for dir in $dirs {
        chainsaw test $"tests/($dir)"
    }

}

def --env "main test once" [
    --dir = "tests"
] {

    main package apply
    
    chainsaw test $dir

}

def --env "main test watch" [
    --dir = "tests"
] {

    watchexec -w kcl -w tests $"./dot.nu test once --dir ($dir)"

}

def --env "main destroy" [
    --provider = "kind"
] {

    mut cluster = "kind"

    main destroy kubernetes $cluster

}

def "main create diagram" [
    composite_resource: string
] {

    let prompt = (
        open prompts/create-diagram.md
            | str replace "REPLACE_COMPOSITE_RESOURCE"
            $composite_resource
    )

    claude $prompt

}

def "main apply service" [] {

    let prompt = ( open prompts/create-service.md )

    claude $prompt

}

def "main observe service" [] {

    let prompt = ( open prompts/observe-service.md )

    claude $prompt

}
def "crossplane compositions generate" [] {

    kcl run kcl/compositions.k |
        save package/compositions.yaml --force

}
