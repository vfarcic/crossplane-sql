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

    SQL["SQL<br>devopstoolkit.live/v1beta1<br>my-db"]:::compositeResource
    
    %% Azure Resources
    ResourceGroup["ResourceGroup<br>azure.upbound.io/v1beta1<br>my-db"]:::azureResource
    Server["Server<br>dbforpostgresql.azure.upbound.io/v1beta1<br>my-db"]:::azureResource
    FirewallRule["FirewallRule<br>dbforpostgresql.azure.upbound.io/v1beta1<br>my-db"]:::azureResource
    
    %% Other Resources
    KubernetesProviderConfig["ProviderConfig<br>kubernetes.crossplane.io/v1alpha1<br>my-db-sql"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db"]:::otherResource
    Database1["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-01"]:::otherResource
    Database2["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-02"]:::otherResource
    ConnectionSecret["Object<br>kubernetes.crossplane.io/v1alpha2<br>my-db-secret"]:::otherResource
    
    %% Resource Relationships
    SQL --> ResourceGroup
    ResourceGroup --> Server
    Server --> FirewallRule
    
    SQL --> KubernetesProviderConfig
    SQL --> SQLProviderConfig
    
    SQLProviderConfig --> Database1
    SQLProviderConfig --> Database2
    
    Server --> ConnectionSecret
```