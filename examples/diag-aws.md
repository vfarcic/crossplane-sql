# dot-sql

```yaml
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
    classDef SQL fill:#3498db,color:white
    classDef AWS fill:#e67e22,color:white
    classDef Other fill:#9b59b6,color:white

    SQL["SQL<br>devopstoolkit.live/v1beta1<br>my-db"]:::SQL
    VPC["VPC<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    InternetGateway["InternetGateway<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    RouteTable["RouteTable<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    Route["Route<br>ec2.aws.m.upbound.io/v1beta2<br>my-db"]:::AWS
    MainRouteTableAssociation["MainRouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    SecurityGroup["SecurityGroup<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    SecurityGroupRule["SecurityGroupRule<br>ec2.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    SubnetA["Subnet<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-a"]:::AWS
    SubnetB["Subnet<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-b"]:::AWS
    SubnetC["Subnet<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-c"]:::AWS
    RouteTableAssociationA["RouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-1a"]:::AWS
    RouteTableAssociationB["RouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-1b"]:::AWS
    RouteTableAssociationC["RouteTableAssociation<br>ec2.aws.m.upbound.io/v1beta1<br>my-db-1c"]:::AWS
    RDSSubnetGroup["SubnetGroup<br>rds.aws.m.upbound.io/v1beta1<br>my-db"]:::AWS
    RDSInstance["Instance<br>rds.aws.m.upbound.io/v1beta3<br>my-db"]:::AWS
    KubernetesObject["Object<br>kubernetes.crossplane.io/v1alpha2<br>my-db-secret"]:::Other
    ProviderConfigK8s["ProviderConfig<br>kubernetes.crossplane.io/v1alpha1<br>my-db-sql"]:::Other
    ProviderConfigSQL["ProviderConfig<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db"]:::Other
    DatabaseA["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-01"]:::Other
    DatabaseB["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-02"]:::Other
    
    SQL --> VPC
    VPC --> InternetGateway
    VPC --> RouteTable
    RouteTable --> MainRouteTableAssociation
    VPC --> MainRouteTableAssociation
    RouteTable --> Route
    InternetGateway --> Route
    VPC --> SecurityGroup
    SecurityGroup --> SecurityGroupRule
    VPC --> SubnetA
    VPC --> SubnetB
    VPC --> SubnetC
    RouteTable --> RouteTableAssociationA
    SubnetA --> RouteTableAssociationA
    RouteTable --> RouteTableAssociationB
    SubnetB --> RouteTableAssociationB
    RouteTable --> RouteTableAssociationC
    SubnetC --> RouteTableAssociationC
    SubnetA --> RDSSubnetGroup
    SubnetB --> RDSSubnetGroup
    SubnetC --> RDSSubnetGroup
    RDSSubnetGroup --> RDSInstance
    SecurityGroup --> RDSInstance
    RDSInstance --> KubernetesObject
    SQL --> ProviderConfigK8s
    SQL --> ProviderConfigSQL
    ProviderConfigSQL --> DatabaseA
    ProviderConfigSQL --> DatabaseB
```