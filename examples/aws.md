# AWS EKS Example

## Setup

```bash
devbox shell

chmod +x dot.nu

./dot.nu setup aws

source .env

kubectl --namespace infra apply \
    --filename examples/aws-secret.yaml
```

## Create an PostgreSQL RDS Server

```bash
cat examples/aws.yaml

kubectl --namespace infra apply --filename examples/aws.yaml
    
crossplane beta trace --namespace infra sql my-db
```

> Wait until all the resources are `Available`

## Destroy 

```sh
./dot.nu destroy
```