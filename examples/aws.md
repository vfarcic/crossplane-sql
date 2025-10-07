# AWS RDS Example

## Setup

```bash
devbox shell

chmod +x dot.nu

./dot.nu setup --provider aws

source .env

kubectl --namespace a-team apply \
    --filename examples/aws-secret.yaml
```

## Create a PostgreSQL RDS Server

```bash
cat examples/aws.yaml

kubectl --namespace a-team apply --filename examples/aws.yaml

kubectl --namespace a-team get sqls

kubectl --namespace a-team get managed
```

> Wait until all the resources are `Available`

## Destroy 

```sh
kubectl --namespace a-team delete --filename examples/aws.yaml

kubectl --namespace a-team get managed
```

> Wait until all the resources are `Available`

```sh
./dot.nu destroy
```