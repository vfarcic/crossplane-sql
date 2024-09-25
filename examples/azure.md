# Azure PostgreSQL Example

## Setup

This section sets up the environment to test an example of a Crossplane Composition that manages PostgreSQL instances in Azure.

### Environment

Setup up an environment with all the tools required to run the example.

> Please skip the command that follows if you're using DevContainer.

```bash
devbox shell
```

## Azure Credentials

> Replace `[...]` with your Azure Tenant ID

```bash
export AZURE_TENANT=[...]

az login --tenant $AZURE_TENANT

export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad sp create-for-rbac --sdk-auth --role Owner \
    --scopes /subscriptions/$SUBSCRIPTION_ID \
    | tee azure-creds.json
```

### Crossplane

Please skip the command that follows if you already have a Kubernetes cluster that you would like to use as a Crossplane control plane.

```sh
kind create cluster
```

Install Crossplane.

```sh
helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait
```

Create a secret with Azure credentials.

```sh
kubectl --namespace crossplane-system \
    create secret generic azure-creds \
    --from-file creds=./azure-creds.json
```

Apply providers that cannot be installed as Configuration dependencies.

```sh
kubectl apply \
    --filename providers/provider-kubernetes-incluster.yaml

kubectl apply \
    --filename providers/provider-helm-incluster.yaml
```

Apply the Composition configuration and its dependencies.

```sh
kubectl apply --filename config.yaml
```

Create the `infra` Namespace where we'll apply the SQL Claim.

```sh
kubectl create namespace infra
```

Take a look at the status of the packages.

```sh
kubectl get pkgrev
```

> Repeat the previous command until all the packages are healthy

```sh
kubectl apply --filename examples/provider-config-azure.yaml

kubectl --namespace infra apply \
    --filename examples/azure-secret.yaml
```

## Create a PostgreSQL Instance

TODO: Write it

## Destroy

Delete the example Claim.

```bash
kubectl --namespace infra delete --filename examples/azure.yaml
```

Retrieve all managed resources expanded from the Claim.

```sh
kubectl get managed
```

> Repeat the previous command if there are still resources to be deleted (ignore `database`).
