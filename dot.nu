#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu

def main [] {}

def "main setup" [
    hyperscaler: string
] {

    rm --force .env

    main create kubernetes kind

    main apply crossplane --hyperscaler $hyperscaler

    kubectl apply --filename config.yaml

    wait crossplane

    apply providerconfig $hyperscaler

    kubectl create namespace infra

}

def "main destroy" [] {

    main delete crossplane

    main destroy kubernetes kind

}
