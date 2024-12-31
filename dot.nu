#!/usr/bin/env nu

source scripts/kubernetes.nu
source scripts/crossplane.nu
source scripts/get-hyperscaler.nu
# source scripts/ingress.nu
# source scripts/github.nu
# source scripts/argocd.nu
# source scripts/backstage.nu

def main [] {}

def "main setup" [
    hyperscaler: string
] {

    rm --force .env

    main create kubernetes kind

    main apply crossplane --hyperscaler $hyperscaler

    kubectl apply --filename config.yaml

    print $"(ansi yellow_bold)Waiting for Crossplane providers to be deployed \(up to 30 min.\)...(ansi reset)"

    sleep 60sec

    (
        kubectl wait
            --for=condition=healthy provider.pkg.crossplane.io
            --all --timeout 30m
    )

}
