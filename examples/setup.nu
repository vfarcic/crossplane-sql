#!/usr/bin/env nu

def main [] {

    rm --force .env
    touch .env

    set-cluster

    let hyperscaler = get-hyperscaler

    set-crossplane

    match $hyperscaler {
        "aws" => set-aws
        "google" => set-google
        "azure" => set-azure
    }

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

    print $"(ansi yellow_bold)Waiting for Crossplane providers to be deployed \(up to 30 min.\)...(ansi reset)"

    sleep 60sec

    (
        kubectl wait
            --for=condition=healthy provider.pkg.crossplane.io
            --all --timeout 30m
    )

}

def get-hyperscaler [] {

    let hyperscaler = [aws, azure, google]
        | input list $"\n(ansi green_bold)Which Hyperscaler do you want to use?"
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

    kubectl apply --filename examples/provider-config-aws.yaml

}

def set-google [] {

    gcloud auth login

    let project_id = $"dot-(date now | format date "%Y%m%d%H%M%S")"
    open settings.yaml
        | upsert google.projectID $project_id
        | save settings.yaml --force

    gcloud projects create $project_id

    start $"https://console.cloud.google.com/billing/enable?project=($project_id)"

    print $"
    Set (ansi yellow_bold)billing account(ansi reset).
    (ansi green_bold)Press any key to continue.(ansi reset)
    "
    input

    start $"https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=($project_id)"
    
    print $"(ansi yellow_bold)
    ENABLE(ansi reset) the API.
    (ansi green_bold)Press any key to continue.(ansi reset)
    "
    input

    let sa_name = "devops-toolkit"

    let sa = $"($sa_name)@($project_id).iam.gserviceaccount.com"
    
    (
        gcloud iam service-accounts create $sa_name 
            --project $project_id
    )

    (
        gcloud projects add-iam-policy-binding
            --role roles/admin $project_id
            --member $"serviceAccount:($sa)"
    )

    (
        gcloud iam service-accounts keys create gcp-creds.json
            --project $project_id --iam-account $sa
    )

    (
        kubectl --namespace crossplane-system
            create secret generic gcp-creds
            --from-file creds=./gcp-creds.json
    )

    open examples/provider-config-google.yaml
        | upsert spec.projectID $project_id
        | save examples/provider-config-google.yaml --force

    kubectl apply --filename examples/provider-config-google.yaml

}

def set-azure [] {

    if AZURE_TENANT not-in $env {
        let value = input $"(ansi green_bold)Enter Azure Tenant: (ansi reset)"
        $env.AZURE_TENANT = $value
    }

    az login --tenant $env.AZURE_TENANT

    let subscription_id = (az account show --query id -o tsv)

    (
        az ad sp create-for-rbac --sdk-auth --role Owner
            --scopes $"/subscriptions/($subscription_id)"
            | save azure-creds.json --force
    )

    (
        kubectl --namespace crossplane-system
            create secret generic azure-creds
            --from-file creds=./azure-creds.json
    )

    kubectl apply --filename examples/provider-config-azure.yaml

}
