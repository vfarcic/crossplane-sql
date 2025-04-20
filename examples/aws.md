# AWS RDS Example

## Setup

```bash
devbox shell

chmod +x dot.nu

./dot.nu setup --provider aws --preview true

source .env

kubectl --namespace a-team apply \
    --filename examples/aws-secret.yaml
```

## Create a PostgreSQL RDS Server

```bash
cat examples/aws.yaml

kubectl --namespace a-team apply --filename examples/aws.yaml

kubectl tree --namespace a-team sqls my-db
```

> Wait until all the resources are `Available`

## Destroy 

```sh
./dot.nu destroy
```