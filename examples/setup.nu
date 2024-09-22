#!/usr/bin/env nu

def main [] {

    rm --force .env
    touch .env

    set-cluster

    let hyperscaler = get-hyperscaler

    set-crossplane

    set-aws

    kubectl create namespace infra

}

def set-cluster [] {

    kind create cluster --config kind.yaml

    (
        kubectl apply
            --filename "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"
    )
}

def set-crossplane [] {

    (
        helm upgrade --install crossplane crossplane
            --repo https://charts.crossplane.io/stable
            --set args='{"--enable-usages"}'
            --namespace crossplane-system --create-namespace --wait
    )

    kubectl apply --filename config.yaml

    (
        kubectl apply
            --filename providers/provider-kubernetes-incluster.yaml
    )

    (
        kubectl apply
            --filename providers/provider-helm-incluster.yaml
    )

    print $"(ansi yellow_bold)Waiting for Crossplane providers to be deployed...(ansi reset)"

    sleep 60sec

    (
        kubectl wait
            --for=condition=healthy provider.pkg.crossplane.io
            --all --timeout 5m
    )

}

def get-hyperscaler [] {

    let hyperscaler = [aws]
        | input list $"\n(ansi green_bold)Which Hyperscaler do you want to use?(ansi yellow_bold)"
    print $"(ansi reset)"

    open settings.yaml
        | upsert hyperscaler $hyperscaler
        | save settings.yaml --force
    $"export HYPERSCALER=($hyperscaler)\n"
        | save --append .env

    $hyperscaler

}

def set-aws [] {

    if AWS_ACCESS_KEY_ID not-in $env {
        let value = input $"(ansi green_bold)Enter AWS Access Key ID: (ansi reset)"
        $env.AWS_ACCESS_KEY_ID = $value
    }
    $"export AWS_ACCESS_KEY_ID=($env.AWS_ACCESS_KEY_ID)\n"
        | save --append .env

    if AWS_SECRET_ACCESS_KEY not-in $env {
        let value = input $"(ansi green_bold)Enter AWS Secret Access Key: (ansi reset)"
        $env.AWS_SECRET_ACCESS_KEY = $value
    }
    $"export AWS_SECRET_ACCESS_KEY=($env.AWS_SECRET_ACCESS_KEY)\n"
        | save --append .env

    $"[default]
    aws_access_key_id = ($env.AWS_ACCESS_KEY_ID)
    aws_secret_access_key = ($env.AWS_SECRET_ACCESS_KEY)
    " | save aws-creds.conf --force

    (
        kubectl --namespace crossplane-system
            create secret generic aws-creds
            --from-file creds=./aws-creds.conf
    )

    kubectl apply --filename $"examples/provider-config-aws.yaml"

}
