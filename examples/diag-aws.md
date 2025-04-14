# dot-sql

```yaml
---
apiVersion: devopstoolkit.live/v1beta1
kind: SQL
metadata:
  name: my-db
spec:
  version: "16.3"
  size: medium
  region: us-east-1
  databases:
    - db-01
    - db-02
  crossplane:
    compositionSelector:
      matchLabels:
        provider: aws
        db: postgresql
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef awsResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>devopstoolkit.live/v1beta1<br>my-db"]:::compositeResource

    %% AWS Resources
    VPC["VPC<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    Gateway["InternetGateway<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    MainRTA["MainRouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    RouteTable["RouteTable<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    Route["Route<br>ec2.aws.m.upbound.io/v1beta2<br>my-db"]:::awsResource
    SecGroup["SecurityGroup<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    SecGroupRule["SecurityGroupRule<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    SubnetA["Subnet<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-a"]:::awsResource
    SubnetB["Subnet<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-b"]:::awsResource
    SubnetC["Subnet<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-c"]:::awsResource
    RTAA["RouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-1a"]:::awsResource
    RTAB["RouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-1b"]:::awsResource
    RTAC["RouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-1c"]:::awsResource
    SubnetGroup["SubnetGroup<br>rds.aws.m.upbound.io/v1beta1<br>my-db"]:::awsResource
    RDSInstance["Instance<br>rds.aws.m.upbound.io/v1beta3<br>my-db"]:::awsResource

    %% Other Resources
    Secret["Secret<br>kubernetes.crossplane.io/v1alpha2<br>my-db-secret"]:::otherResource

    %% Resource Relationships
    SQL --> VPC
    SQL --> Secret

    Gateway --> VPC
    MainRTA --> RouteTable
    MainRTA --> VPC
    RouteTable --> VPC
    Route --> RouteTable
    Route --> Gateway
    SecGroup --> VPC
    SecGroupRule --> SecGroup

    SubnetA --> VPC
    SubnetB --> VPC
    SubnetC --> VPC

    RTAA --> RouteTable
    RTAA --> SubnetA
    RTAB --> RouteTable
    RTAB --> SubnetB
    RTAC --> RouteTable
    RTAC --> SubnetC

    SubnetGroup --> SubnetA
    SubnetGroup --> SubnetB
    SubnetGroup --> SubnetC

    RDSInstance --> SubnetGroup
    RDSInstance --> SecGroup

    Secret --> RDSInstance
```