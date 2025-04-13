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

    SQL["SQL<br>devopstoolkit.live/v1beta1<br>my-db"]:::compositeResource
    
    %% Google Cloud Resources
    DatabaseInstance["DatabaseInstance<br>sql.gcp.upbound.io/v1beta1<br>my-db"]:::googleResource
    User["User<br>sql.gcp.upbound.io/v1beta1<br>my-db"]:::googleResource
    
    %% Kubernetes Resources
    KProviderConfig["ProviderConfig<br>kubernetes.crossplane.io/v1alpha1<br>my-db-sql"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db"]:::otherResource
    ConnectionSecret["Object<br>kubernetes.crossplane.io/v1alpha2<br>my-db-secret"]:::otherResource
    
    %% Database Resources for db-01 and db-02
    Database1["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-01"]:::otherResource
    Database2["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-db-02"]:::otherResource
    
    %% Resource Relationships
    SQL --> DatabaseInstance
    
    DatabaseInstance --> User
    User --> ConnectionSecret
    
    ConnectionSecret --> KProviderConfig
    
    DatabaseInstance --> ConnectionSecret
    
    SQL --> SQLProviderConfig
    SQLProviderConfig --> Database1
    SQLProviderConfig --> Database2
```