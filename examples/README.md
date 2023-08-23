## Setup Specific to Google Cloud (optional)

```bash
export PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

gcloud projects create $PROJECT_ID

echo https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=$PROJECT_ID

# Open the URL in a browser and *ENABLE* the API.

export SA_NAME=devops-toolkit

export SA="${SA_NAME}@$PROJECT_ID.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID

export ROLE=roles/admin

gcloud projects add-iam-policy-binding --role $ROLE $PROJECT_ID \
    --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
    --project $PROJECT_ID --iam-account $SA

gcloud container clusters create dot --project $PROJECT_ID \
    --region us-east1 --machine-type e2-standard-4 \
    --num-nodes 1 --no-enable-autoupgrade --enable-autoscaling \
    --min-nodes=1 --max-nodes=6

gcloud container clusters get-credentials dot \
    --project $PROJECT_ID --region us-east1

kubectl create namespace crossplane-system

kubectl --namespace crossplane-system \
    create secret generic gcp-creds \
    --from-file creds=./gcp-creds.json
```

## Common Setup

```bash
helm upgrade --install crossplane crossplane-stable/crossplane \
    --namespace crossplane-system --create-namespace --wait

kubectl apply --filename provider-helm-incluster.yaml

kubectl apply --filename provider-kubernetes-incluster.yaml

kubectl apply --filename ../config.yaml

# Execute only if using Google Cloud
echo "apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-creds
      key: creds" \
    | kubectl apply --filename -
```