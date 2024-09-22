# AWS EKS Example

## Setup

```bash
devbox shell

chmod +x examples/setup.nu

./examples/setup.nu

source .env

kubectl create namespace a-team
```

## Create an EKS Cluster

```bash
cat examples/aws.yaml

kubectl --namespace a-team apply --filename examples/aws.yaml
    
kubectl --namespace a-team get sqlclaims

kubectl get managed
```

## Destroy 

```bash
kubectl --namespace a-team delete --filename ../examples/aws.yaml

kubectl get managed

# Wait until all the resources are deleted (ignore `database`)
```
