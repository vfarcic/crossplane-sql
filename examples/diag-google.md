# dot-sql

```yaml
---
apiVersion: devopstoolkit.live/v1beta1
kind: SQL
metadata:
  name: my-db
spec:
  version: "13"
  size: small
  region: us-east1
  databases:
    - db-01
    - db-02
  crossplane:
    compositionSelector:
      matchLabels:
        provider: google
        db: postgresql
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef googleResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>my-db"]:::compositeResource
    
    %% Google Cloud Resources
    DatabaseInstance["DatabaseInstance<br>my-db"]:::googleResource
    User["User<br>my-db"]:::googleResource
    
    %% Provider Configs
    KProviderConfig["ProviderConfig<br>my-db-sql-kubernetes"]:::otherResource
    HProviderConfig["ProviderConfig<br>my-db-sql-helm"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>my-db"]:::otherResource
    
    %% Database Resources
    Database1["Database<br>my-db-db-01"]:::otherResource
    Database2["Database<br>my-db-db-02"]:::otherResource
    
    %% Secret Resources
    ConnectionSecret["Object<br>my-db-secret"]:::otherResource
    PasswordSecret["Secret<br>my-db-password"]:::otherResource
    
    %% Resource Relationships
    SQL --> DatabaseInstance
    SQL --> KProviderConfig
    SQL --> HProviderConfig
    SQL --> SQLProviderConfig
    
    DatabaseInstance --> User
    User --> ConnectionSecret
    DatabaseInstance --> ConnectionSecret
    
    SQLProviderConfig --> Database1
    SQLProviderConfig --> Database2
    
    PasswordSecret --> DatabaseInstance
    PasswordSecret --> User
```