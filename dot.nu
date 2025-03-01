#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu
source scripts/external-secrets.nu
source scripts/atlas.nu

def main [] {}

def "main setup" [
    provider: string
] {

    rm --force .env

    main create kubernetes kind

    main apply crossplane --provider $provider

    kubectl apply --filename config.yaml

    wait crossplane

    kubectl create namespace infra

    if $provider == "google" {

        (
            apply providerconfig $provider
                --google_project_id $env.PROJECT_ID
        )

        start $"https://console.cloud.google.com/marketplace/product/google/sqladmin.googleapis.com?project=($env.PROJECT_ID)"
            
        print $"
(ansi yellow_bold)ENABLE(ansi reset) the API.
Press any key to continue.
"
        input

        (
            main apply external_secrets $provider
                --google_project_id $env.PROJECT_ID
        )

    } else {

        apply providerconfig $provider 

    }

    main apply atlas

}

def "main destroy" [
    provider: string
] {

    (
        main delete crossplane --kind sqlclaim --name my-db
            --namespace infra
    )

    main destroy kubernetes kind

}
