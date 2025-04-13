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
    - main
  schemas:
    - database: main
      sql: |
        create table videos (
          id varchar(50) not null,
          description text,
          primary key (id)
        );
        create table comments (
          id serial,
          video_id varchar(50) not null,
          description text not null,
          primary key (id),
          CONSTRAINT fk_videos FOREIGN KEY(video_id) REFERENCES videos(id)
        );
  secrets:
    storeName: google
    pullRootPasswordKey: db-root-password
    pushToStore: true
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
    
    %% Other Resources
    KubernetesProviderConfig["ProviderConfig<br>kubernetes.crossplane.io/v1alpha1<br>my-db-sql"]:::otherResource
    PostgreSQLProviderConfig["ProviderConfig<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db"]:::otherResource
    Database["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-main"]:::otherResource
    ConnectionSecret["Object<br>kubernetes.crossplane.io/v1alpha2<br>my-db-secret"]:::otherResource
    PasswordSecret["ExternalSecret<br>external-secrets.io/v1beta1<br>my-db-password"]:::otherResource
    PushSecret["PushSecret<br>external-secrets.io/v1alpha1<br>my-db"]:::otherResource
    AtlasSchema["AtlasSchema<br>db.atlasgo.io/v1alpha1<br>my-db-main"]:::otherResource
    
    %% Resource Relationships
    SQL --> DatabaseInstance
    SQL --> KubernetesProviderConfig
    SQL --> PasswordSecret
    
    DatabaseInstance --> User
    
    User --> ConnectionSecret
    DatabaseInstance --> ConnectionSecret
    
    KubernetesProviderConfig --> ConnectionSecret
    
    PostgreSQLProviderConfig --> Database
    ConnectionSecret --> PostgreSQLProviderConfig
    
    ConnectionSecret --> PushSecret
    ConnectionSecret --> AtlasSchema
    
    Database --> AtlasSchema
```