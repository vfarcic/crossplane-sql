# Google Cloud PostgreSQL Example

## Setup

This section sets up the environment to test an example of a Crossplane Composition that manages PostgreSQL instances in Google Cloud.

### Environment

Setup up an environment with all the tools required to run the example.

> Please skip the command that follows if you're using DevContainer.

```bash
devbox shell
```

### Google Project

Create Google project and a service account.

```bash
gcloud auth login
```

Create a new project.

```sh
export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

gcloud projects create $PROJECT_ID
```

Add billing account.

```sh
echo "Open https://console.cloud.google.com/billing/enable?project=$PROJECT_ID in a browser and **set the billing account**." | gum format
```

Enable `sqladmin` API.

```sh
echo "Open https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=$PROJECT_ID in a browser and **enable** the API." | gum format
```

Create a service account.

```sh
export SA_NAME="devops-toolkit"

export SA="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID

export ROLE="roles/admin"

gcloud projects add-iam-policy-binding --role $ROLE $PROJECT_ID \
    --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $PROJECT_ID --iam-account $SA
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

Create a secret with Google Cloud credentials.

```sh
kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json
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

Modify Project ID in the Google Cloud provider configuration and apply it.

```sh
yq --inplace ".spec.projectID = \"$PROJECT_ID\"" \
    providers/provider-config-google.yaml

kubectl apply --filename providers/provider-config-google.yaml

kubectl --namespace infra apply \
    --filename examples/google-secret.yaml
```

## Create a PostgreSQL Instance

Take a look at the example Claim.

```bash
cat examples/google.yaml
```

Apply the example Claim.

```sh
kubectl --namespace infra apply --filename examples/google.yaml
```

Take a look at the status of the SQL Claim.

```sh
kubectl --namespace infra get sqlclaims
```

Retrieve all managed resources expanded from the Claim.

```sh
kubectl get managed
```

## Destroy

Delete the example Claim.

```bash
kubectl --namespace infra delete --filename examples/google.yaml
```

Retrieve all managed resources expanded from the Claim.

```sh
kubectl get managed
```

> Repeat the previous command if there are still resources to be deleted (ignore `database`).

Delete the Google Cloud project.

```sh
gcloud projects delete $PROJECT_ID
```
