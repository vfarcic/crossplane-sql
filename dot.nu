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
] {

    rm --force .env

    main create kubernetes kind

    main apply ingress nginx --provider kind

    main apply crossplane --preview $preview

    print $"\nApplying (ansi yellow_bold)Crossplane Providers(ansi reset)...\n"

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

    main apply certmanager

    main apply ack --apply_irsa $apply_irsa

    main apply aso --apply_creds $apply_azure_creds

    print $"\nApplying (ansi yellow_bold)Crossplane Composition(ansi reset)...\n"

    kubectl apply --filename package/definition.yaml

    sleep 1sec

    kubectl apply --filename "package/compositions.yaml"

    main apply external_secrets

    main apply atlas

    main apply cnpg

    print $"\nWaiting for (ansi yellow_bold)Crossplane providers(ansi reset) to be healthy...\n"

    (
        kubectl wait
            --for=condition=healthy provider.pkg.crossplane.io
            --all --timeout 300s
    )

    kubectl create namespace a-team

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

def --env "main destroy" [] {

    main destroy kubernetes kind

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

def "main generate diagram" [
    composite_resource: string
    diagram_path: string
] {

    let prompt = (
        open prompts/diagram.md
            | str replace "REPLACE_COMPOSITE_RESOURCE"
            $composite_resource
    )

    claude --print $prompt | save $diagram_path --force

}

def "package generate" [] {

    kcl run kcl/compositions.k |
        save package/compositions.yaml --force

}
