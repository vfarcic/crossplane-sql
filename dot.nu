#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu
source scripts/external-secrets.nu
source scripts/atlas.nu
source scripts/ingress.nu
source scripts/common.nu
source scripts/cnpg.nu
source scripts/ack.nu

def main [] {}

def "main setup" [
    --preview = false
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

    print $"\nApplying (ansi yellow_bold)ACK Controllers(ansi reset)...\n"

    main apply ack

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

def "main package apply" [] {

    kcl run kcl/compositions.k |
        save package/compositions.yaml --force

    kubectl apply --filename package/definition.yaml
    
    sleep 1sec

    kubectl apply --filename package/compositions.yaml

}

def "main test once" [
    --dir = "tests"
] {

    main package apply
    
    chainsaw test $dir

}

def "main test watch" [
    --dir = "tests"
] {

    watchexec -w kcl -w tests $"./dot.nu test once --dir ($dir)"

}

def "main destroy" [] {

    main destroy kubernetes kind

}