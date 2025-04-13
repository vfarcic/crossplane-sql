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
        provider: aws-ack
        db: postgresql
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef awsResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>my-db"]

    %% AWS resources
    VPC["VPC<br>my-db"]
    SecurityGroup["SecurityGroup<br>my-db"]
    SecurityGroupRule["SecurityGroupRule<br>my-db"]
    DBSubnetGroup["DBSubnetGroup<br>my-db"]
    DBInstance["DBInstance<br>my-db"]
    
    Subnet1["Subnet<br>my-db-a"]
    Subnet2["Subnet<br>my-db-b"]
    Subnet3["Subnet<br>my-db-c"]
    
    %% Other resources
    Database1["Database<br>my-db-db-01"]
    Database2["Database<br>my-db-db-02"]
    Secret["Secret<br>my-db-secret"]
    ProviderConfig1["ProviderConfig<br>my-db-sql-kubernetes"]
    ProviderConfig2["ProviderConfig<br>my-db-sql-helm"]
    SQLProviderConfig["ProviderConfig<br>my-db"]

    %% Connections from SQL composite
    SQL --> VPC
    SQL --> SecurityGroup
    SQL --> SecurityGroupRule
    SQL --> Subnet1
    SQL --> Subnet2
    SQL --> Subnet3
    SQL --> DBSubnetGroup
    SQL --> DBInstance
    SQL --> Database1
    SQL --> Database2
    SQL --> Secret
    SQL --> ProviderConfig1
    SQL --> ProviderConfig2
    SQL --> SQLProviderConfig

    %% Resource relationships
    SecurityGroup --> VPC
    SecurityGroupRule --> SecurityGroup
    Subnet1 --> VPC
    Subnet2 --> VPC
    Subnet3 --> VPC
    DBSubnetGroup --> Subnet1
    DBSubnetGroup --> Subnet2
    DBSubnetGroup --> Subnet3
    DBInstance --> DBSubnetGroup
    DBInstance --> SecurityGroup
    Database1 --> SQLProviderConfig
    Database2 --> SQLProviderConfig
    Secret --> DBInstance

    %% Style classes
    SQL:::compositeResource
    VPC:::awsResource
    SecurityGroup:::awsResource
    SecurityGroupRule:::awsResource
    DBSubnetGroup:::awsResource
    DBInstance:::awsResource
    Subnet1:::awsResource
    Subnet2:::awsResource
    Subnet3:::awsResource
    Database1:::otherResource
    Database2:::otherResource
    Secret:::otherResource
    ProviderConfig1:::otherResource
    ProviderConfig2:::otherResource
    SQLProviderConfig:::otherResource
```