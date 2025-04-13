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
        provider: aws-ack
        db: postgresql
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef awsResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>devopstoolkit.live/v1beta1<br>my-db"]:::compositeResource

    %% AWS Resources
    VPC["VPC<br>ec2.services.k8s.aws/v1alpha1<br>my-db"]:::awsResource
    InternetGateway["InternetGateway<br>ec2.services.k8s.aws/v1alpha1<br>my-db"]:::awsResource
    RouteTable["RouteTable<br>ec2.services.k8s.aws/v1alpha1<br>my-db"]:::awsResource
    SecurityGroup["SecurityGroup<br>ec2.services.k8s.aws/v1alpha1<br>my-db"]:::awsResource
    DBSubnetGroup["DBSubnetGroup<br>rds.services.k8s.aws/v1alpha1<br>my-db"]:::awsResource
    DBInstance["DBInstance<br>rds.services.k8s.aws/v1alpha1<br>my-db"]:::awsResource
    SubnetA["Subnet<br>ec2.services.k8s.aws/v1alpha1<br>my-db-a"]:::awsResource
    SubnetB["Subnet<br>ec2.services.k8s.aws/v1alpha1<br>my-db-b"]:::awsResource
    SubnetC["Subnet<br>ec2.services.k8s.aws/v1alpha1<br>my-db-c"]:::awsResource

    %% Other Resources
    Object["Object<br>kubernetes.v1alpha2<br>my-db-secret"]:::otherResource
    PCKubernetes["ProviderConfig<br>kubernetes.crossplane.io/v1alpha1<br>my-db-sql"]:::otherResource
    PCPostgres["ProviderConfig<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db"]:::otherResource
    DBdb01["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-01"]:::otherResource
    DBdb02["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-02"]:::otherResource

    %% Resource Relationships
    SQL --> VPC
    SQL --> PCKubernetes
    SQL --> PCPostgres
    SQL --> DBdb01
    SQL --> DBdb02
    
    InternetGateway --> VPC
    RouteTable --> VPC
    RouteTable --> InternetGateway
    
    SecurityGroup --> VPC
    
    SubnetA --> VPC
    SubnetB --> VPC
    SubnetC --> VPC
    SubnetA --> RouteTable
    SubnetB --> RouteTable
    SubnetC --> RouteTable
    
    DBSubnetGroup --> SubnetA
    DBSubnetGroup --> SubnetB
    DBSubnetGroup --> SubnetC
    
    DBInstance --> DBSubnetGroup
    DBInstance --> SecurityGroup
    
    Object --> DBInstance
    
    PCPostgres --> Object
    
    DBdb01 --> PCPostgres
    DBdb02 --> PCPostgres
```