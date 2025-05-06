#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu
source scripts/external-secrets.nu
source scripts/atlas.nu
source scripts/ingress.nu
source scripts/common.nu
source scripts/cnpg.nu
source scripts/ack.nu
source scripts/aso.nu
source scripts/cert-manager.nu

def main [] {}

def --env "main setup" [
    --preview = false
    --apply_irsa = false
    --apply_azure_creds = false
    --provider: string = ""
] {

    let date_start = (date now)

    rm --force .env

    mut cluster = "kind"

    if $provider == "ack" {
        $cluster = "aws"
    }

    main create kubernetes $cluster

    main apply certmanager

    let ingress = { main apply ingress nginx --provider kind }

    let crossplane = {
        main apply crossplane --preview $preview
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
        (
            kubectl wait
                --for=condition=healthy provider.pkg.crossplane.io
                --all --timeout 600s
        )
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

    }

    let ack = { main apply ack --apply_irsa $apply_irsa }

    let eso = { main apply external_secrets }

    let atlas = { main apply atlas }

    let cnpg = { main apply cnpg }

    [ $ingress, $crossplane, $ack, $eso, $atlas, $cnpg ]
        | par-each { |command| do $command }

    # There is user input so we're running it outside of par-each
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

    package generate

    kubectl apply --filename package/definition.yaml
    
    sleep 1sec

    kubectl apply --filename package/compositions.yaml

}

def --env "main test full" [] {

    main setup --preview true

    main package apply

    # FIXME: "cnpg"
    let dirs = [
        "aws"
        "aws-ack"
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
    if $provider == "ack" {
        $cluster = "aws"
        do --ignore-errors { main delete ack }
    }

    main destroy kubernetes $cluster

}

def "main publish" [
    --version = ""
] {

    mut version = $version
    if $version == "" {
        $version = $env.VERSION
    }

    package generate

    crossplane xpkg login --token $env.UP_TOKEN

    (
        crossplane xpkg build --package-root package
            --package-file sql.xpkg
    )

    (
        crossplane xpkg push --package-files sql.xpkg 
            $"xpkg.upbound.io/($env.UP_ACCOUNT)/dot-sql:($version)"
    )

    rm --force package/sql.xpkg

    open config.yaml
        | upsert spec.package $"xpkg.upbound.io/devops-toolkit/dot-sql:($version)"
        | save config.yaml --force

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
def "package generate" [] {

    kcl run kcl/compositions.k |
        save package/compositions.yaml --force

}
