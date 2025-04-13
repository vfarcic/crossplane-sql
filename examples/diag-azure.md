# dot-sql

```yaml
apiVersion: devopstoolkit.live/v1beta1
kind: SQL
metadata:
  name: my-db
spec:
  version: '11'
  size: small
  region: eastus
  databases:
    - db-01
    - db-02
  crossplane:
    compositionSelector:
      matchLabels:
        provider: azure
        db: postgresql
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef azureResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>my-db"]:::compositeResource
    
    %% Azure Resources
    ResourceGroup["ResourceGroup<br>my-db"]:::azureResource
    Server["Server<br>my-db"]:::azureResource
    FirewallRule["FirewallRule<br>my-db"]:::azureResource
    
    %% Other Resources
    KProviderConfig["ProviderConfig<br>my-db-sql-kubernetes"]:::otherResource
    HProviderConfig["ProviderConfig<br>my-db-sql-helm"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>my-db"]:::otherResource
    Database1["Database<br>my-db-db-01"]:::otherResource
    Database2["Database<br>my-db-db-02"]:::otherResource
    PasswordSecret["Secret<br>my-db-password"]:::otherResource
    ConnectionSecret["Object<br>my-db-secret"]:::otherResource
    
    %% Resource Relationships
    SQL --> ResourceGroup
    SQL --> KProviderConfig
    SQL --> HProviderConfig
    SQL --> SQLProviderConfig
    
    ResourceGroup --> Server
    Server --> FirewallRule
    
    SQLProviderConfig --> Database1
    SQLProviderConfig --> Database2
    
    Server --> ConnectionSecret
    Server --> PasswordSecret
    ConnectionSecret --> Database1
    ConnectionSecret --> Database2