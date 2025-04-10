#!/usr/bin/env nu

def "main apply certmanager" [] {

    (
        helm upgrade --install cert-manager cert-manager
            --repo https://charts.jetstack.io
            --namespace cert-manager --create-namespace
            --set crds.enabled=true --wait
    )

}