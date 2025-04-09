# AWS ACK RDS Example

## Setup

```bash
devbox shell

chmod +x dot.nu

./dot.nu setup --apply_irsa true --preview true

source .env

kubectl --namespace infra apply \
    --filename examples/aws-secret.yaml
```

## Create an PostgreSQL RDS Server

```bash
cat examples/aws-ack.yaml

kubectl --namespace infra apply --filename examples/aws-ack.yaml
    
kubectl tree --namespace a-team sqls my-db
```

> Wait until all the resources are `Available`

```sh
kubectl --namespace infra delete --filename examples/aws-ack.yaml

kubectl --namespace a-team get \
    vpcs.ec2.services.k8s.aws,internetgateways.ec2.services.k8s.aws,routetables.ec2.services.k8s.aws,securitygroups.ec2.services.k8s.aws,subnets.ec2.services.k8s.aws,dbsubnetgroups.rds.services.k8s.aws,dbinstances.rds.services.k8s.aws
```

> Wait until all resources are removed.

## Destroy 

```sh
./dot.nu destroy
```