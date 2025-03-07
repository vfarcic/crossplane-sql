#!/usr/bin/env nu

def --env "main apply external_secrets" [
] {

    (
        helm repo add external-secrets
            https://charts.external-secrets.io
    )

    (
        helm upgrade --install
            external-secrets external-secrets/external-secrets
            --namespace external-secrets --create-namespace --wait
    )






    mut project_id = ""

    helm repo add crossplane https://charts.crossplane.io/stable

    (
        helm upgrade --install crossplane crossplane/crossplane
            --namespace crossplane-system --create-namespace
            --set args='{"--enable-usages"}'
            --wait
    )

    if $provider == "google" {

        if PROJECT_ID in $env {
            $project_id = $env.PROJECT_ID
        } else {

            gcloud auth login

            $project_id = $"dot-(date now | format date "%Y%m%d%H%M%S")"
            $env.PROJECT_ID = $project_id
            $"export PROJECT_ID=($project_id)\n" | save --append .env

            gcloud projects create $project_id

            start $"https://console.cloud.google.com/billing/enable?project=($project_id)"
    
            print $"
Select the (ansi yellow_bold)Billing account(ansi reset) and press the (ansi yellow_bold)SET ACCOUNT(ansi reset) button.
Press any key to continue.
"
            input

        }

        let sa_name = "devops-toolkit"

        let sa = $"($sa_name)@($project_id).iam.gserviceaccount.com"

        let project = $project_id
    
        do --ignore-errors {(
            gcloud iam service-accounts create $sa_name
                --project $project
        )}

        sleep 5sec

        print $project_id
        print $sa
    
        (
            gcloud projects add-iam-policy-binding
                --role roles/admin $project_id
                --member $"serviceAccount:($sa)"
        )
    
        (
            gcloud iam service-accounts keys
                create gcp-creds.json --project $project_id
                --iam-account $sa
        )
    
        (
            kubectl --namespace crossplane-system
                create secret generic gcp-creds
                --from-file creds=./gcp-creds.json
        )

    } else if $provider == "aws" {

        if AWS_ACCESS_KEY_ID not-in $env {
            $env.AWS_ACCESS_KEY_ID = input $"(ansi yellow_bold)Enter AWS Access Key ID: (ansi reset)"
        }
        $"export AWS_ACCESS_KEY_ID=($env.AWS_ACCESS_KEY_ID)\n"
            | save --append .env

        if AWS_SECRET_ACCESS_KEY not-in $env {
            $env.AWS_SECRET_ACCESS_KEY = input $"(ansi yellow_bold)Enter AWS Secret Access Key: (ansi reset)"
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

    } else if $provider == "azure" {

        mut azure_tenant = ""
        if AZURE_TENANT not-in $env {
            $azure_tenant = input $"(ansi yellow_bold)Enter Azure Tenant: (ansi reset)"
        } else {
            $azure_tenant = $env.AZURE_TENANT
        }
        $"export AZURE_TENANT=($azure_tenant)\n"
            | save --append .env
        
        if $skip_login == false {
            az login --tenant $azure_tenant
        }
    
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

    }

    if $app {

        print $"(ansi green_bold)Applying `dot-application` Configuration...(ansi reset)"

        {
            apiVersion: "pkg.crossplane.io/v1"
            kind: "Configuration"
            metadata: { name: "crossplane-app" }
            spec: { package: "xpkg.upbound.io/devops-toolkit/dot-application:v0.7.23" }
        } | to yaml | kubectl apply --filename -

        if $policies {

            {
                apiVersion: "admissionregistration.k8s.io/v1"
                kind: "ValidatingAdmissionPolicy"
                metadata: { name: "dot-app" }
                spec: {
                    failurePolicy: "Fail"
                    matchConstraints: {
                        resourceRules: [{
                            apiGroups:   ["devopstoolkit.live"]
                            apiVersions: ["*"]
                            operations:  ["CREATE", "UPDATE"]
                            resources:   ["appclaims"]
                        }]
                    }
                    validations: [
                        {
                            expression: "has(object.spec.parameters.scaling) && has(object.spec.parameters.scaling.enabled) && object.spec.parameters.scaling.enabled"
                            message: "`spec.parameters.scaling.enabled` must be set to `true`."
                        }, {
                            expression: "has(object.spec.parameters.scaling) && object.spec.parameters.scaling.min > 1"
                            message: "`spec.parameters.scaling.min` must be greater than `1`."
                        }
                    ]
                }
            } | to yaml | kubectl apply --filename -

            {
                apiVersion: "admissionregistration.k8s.io/v1"
                kind: "ValidatingAdmissionPolicyBinding"
                metadata: { name: "dot-app" }
                spec: {
                    policyName: "dot-app"
                    validationActions: ["Deny"]
                }
            } | to yaml | kubectl apply --filename -

        }

    }

    if $db {

        print $"(ansi green_bold)Applying `dot-sql` Configuration...(ansi reset)"

        if $provider == "google" {
            
            start $"https://console.cloud.google.com/marketplace/product/google/sqladmin.googleapis.com?project=($project_id)"
            
            print $"
(ansi yellow_bold)ENABLE(ansi reset) the API.
Press any key to continue.
"
            input

        }

        {
            apiVersion: "pkg.crossplane.io/v1"
            kind: "Configuration"
            metadata: { name: "crossplane-sql" }
            spec: { package: "xpkg.upbound.io/devops-toolkit/dot-sql:v1.0.14" }
        } | to yaml | kubectl apply --filename -

    }

    if $github {

        print $"(ansi green_bold)Applying `dot-github` Configuration...(ansi reset)"

        {
            apiVersion: "pkg.crossplane.io/v1"
            kind: "Configuration"
            metadata: { name: "devops-toolkit-dot-github" }
            spec: { package: "xpkg.upbound.io/devops-toolkit/dot-github:v0.0.57" }
        } | to yaml | kubectl apply --filename -

    }

    {
        apiVersion: "v1"
        kind: "ServiceAccount"
        metadata: {
            name: "crossplane-provider-helm"
            namespace: "crossplane-system"
        }
    } | to yaml | kubectl apply --filename -
    
    {
        apiVersion: "rbac.authorization.k8s.io/v1"
        kind: "ClusterRoleBinding"
        metadata: {  name: crossplane-provider-helm }
        subjects: [{
            kind: "ServiceAccount"
            name: "crossplane-provider-helm"
            namespace: "crossplane-system"
        }]
        roleRef: {
            kind: "ClusterRole"
            name: "cluster-admin"
            apiGroup: "rbac.authorization.k8s.io"
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1alpha1"
        kind: "ControllerConfig"
        metadata: { name: "crossplane-provider-helm" }
        spec: { serviceAccountName: "crossplane-provider-helm" }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1"
        kind: "Provider"
        metadata: { name: "crossplane-provider-helm" }
        spec: {
            package: "xpkg.upbound.io/crossplane-contrib/provider-helm:v0.19.0"
            controllerConfigRef: { name: "crossplane-provider-helm" }
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "v1"
        kind: "ServiceAccount"
        metadata: {
            name: "crossplane-provider-kubernetes"
            namespace: "crossplane-system"
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "rbac.authorization.k8s.io/v1"
        kind: "ClusterRoleBinding"
        metadata: { name: "crossplane-provider-kubernetes" }
        subjects: [{
            kind: "ServiceAccount"
            name: "crossplane-provider-kubernetes"
            namespace: "crossplane-system"
        }]
        roleRef: {
            kind: "ClusterRole"
            name: "cluster-admin"
            apiGroup: "rbac.authorization.k8s.io"
        }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1alpha1"
        kind: "ControllerConfig"
        metadata: { name: "crossplane-provider-kubernetes" }
        spec: { serviceAccountName: "crossplane-provider-kubernetes" }
    } | to yaml | kubectl apply --filename -

    {
        apiVersion: "pkg.crossplane.io/v1"
        kind: "Provider"
        metadata: { name: "crossplane-provider-kubernetes" }
        spec: {
            package: "xpkg.upbound.io/crossplane-contrib/provider-kubernetes:v0.15.0"
            controllerConfigRef: { name: "crossplane-provider-kubernetes" }
        }
    } | to yaml | kubectl apply --filename -

    wait crossplane

    {
        apiVersion: "kubernetes.crossplane.io/v1alpha1"
        kind: "ProviderConfig"
        metadata: { name: "default" }
        spec: { credentials: { source: "InjectedIdentity" } }
    } | to yaml | kubectl apply --filename -

    if $db and $provider != "none" {

        (
            apply providerconfig $provider
                --google_project_id $project_id
        )

    }

    if ($github_user | is-not-empty) and ($github_token | is-not-empty) {

        {
            apiVersion: v1,
            kind: Secret,
            metadata: {
                name: github,
                namespace: crossplane-system
            },
            type: Opaque,
            stringData: {
                credentials: $"{\"token\":\"($github_token)\",\"owner\":\"($github_user)\"}"
            }
        } | to yaml | kubectl apply --filename -

        if $app or $github {

            {
                apiVersion: "github.upbound.io/v1beta1",
                kind: ProviderConfig,
                metadata: {
                    name: default
                },
                spec: {
                    credentials: {
                        secretRef: {
                            key: credentials,
                            name: github,
                            namespace: crossplane-system,
                        },
                        source: Secret
                    }
                }
            } | to yaml | kubectl apply --filename -

        }

    }

}
