#!/usr/bin/env nu

def --env "main apply aso" [
    --namespace = "default"
    --apply_creds = true
    --crd_pattern = "resources.azure.com/*;dbforpostgresql.azure.com/*"
] {

    (
        helm upgrade --install aso2 azure-service-operator
            --repo https://raw.githubusercontent.com/Azure/azure-service-operator/main/v2/charts
            --namespace=azureserviceoperator-system
            --create-namespace
            --set $"crdPattern='($crd_pattern)'"
            --wait
    )

    if $apply_creds { main apply aso_creds }

}

def --env "main apply aso_creds" [
    --namespace = "default"
] {

    mut azure_tenant = ""
    if AZURE_TENANT not-in $env {
        $azure_tenant = input $"(ansi yellow_bold)Enter Azure Tenant: (ansi reset)"
    } else {
        $azure_tenant = $env.AZURE_TENANT
    }
    $"export AZURE_TENANT=($azure_tenant)\n" | save --append .env

    az login --tenant $azure_tenant

    let subscription_id = (az account show --query id -o tsv)

    let azure_data = (
        az ad sp create-for-rbac --sdk-auth --role Owner
            --scopes $"/subscriptions/($subscription_id)" | from json
    )

    {
        apiVersion: "v1"
        kind: "Secret"
        metadata: {
            name: "aso-credential"
        }
        stringData: {
            AZURE_SUBSCRIPTION_ID: $azure_data.subscriptionId
            AZURE_TENANT_ID: $azure_data.tenantId
            AZURE_CLIENT_ID: $azure_data.clientId
            AZURE_CLIENT_SECRET: $azure_data.clientSecret
            AZURE_SYNC_PERIOD: "1m"
        }
    } | to yaml | kubectl --namespace $namespace apply --filename -

}
