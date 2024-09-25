# AWS EKS Example

## Setup

```bash
devbox shell

chmod +x examples/setup.nu

./examples/setup.nu

source .env

kubectl --namespace infra apply --filename examples/aws-secret.yaml
```

## Create an EKS Cluster

```bash
cat examples/aws.yaml

kubectl --namespace infra apply --filename examples/aws.yaml
    
kubectl --namespace infra get sqlclaims

kubectl get managed
```

## Destroy 

```bash
kubectl --namespace infra delete --filename examples/aws.yaml

kubectl get managed

# Wait until all the resources are deleted (ignore `database`)
```
