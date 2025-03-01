#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu
source scripts/external-secrets.nu

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

        (
            main apply external_secrets $provider
                --google_project_id $env.PROJECT_ID
        )

    } else {

        apply providerconfig $provider 

    }

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
