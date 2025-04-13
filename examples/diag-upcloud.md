# dot-sql

```yaml
---
apiVersion: devopstoolkit.live/v1beta1
kind: SQL
metadata:
  name: my-db
spec:
  size: small
  region: us-nyc1
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
  crossplane:
    compositionSelector:
      matchLabels:
        provider: upcloud
        db: postgresql
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef upcloudResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>devopstoolkit.live/v1beta1<br>my-db"]:::compositeResource
    
    Router["Router<br>network.upcloud.com/v1alpha1<br>my-db"]:::upcloudResource
    Network["Network<br>network.upcloud.com/v1alpha1<br>my-db"]:::upcloudResource
    ManagedDatabasePostgresql["ManagedDatabasePostgresql<br>database.upcloud.com/v1alpha1<br>my-db"]:::upcloudResource
    
    KProviderConfig["ProviderConfig<br>kubernetes.crossplane.io/v1alpha1<br>my-db-sql"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db"]:::otherResource
    
    Database["Database<br>postgresql.sql.crossplane.io/v1alpha1<br>my-db-main"]:::otherResource
    
    ConnectionSecret["Object<br>kubernetes.crossplane.io/v1alpha2<br>my-db-secret"]:::otherResource
    
    AtlasSchema["AtlasSchema<br>db.atlasgo.io/v1alpha1<br>my-db-main"]:::otherResource
    
    SQL --> Router
    
    Router --> Network
    Network --> ManagedDatabasePostgresql
    
    ManagedDatabasePostgresql --> ConnectionSecret
    ConnectionSecret --> KProviderConfig
    
    SQL --> SQLProviderConfig
    SQLProviderConfig --> Database
    
    ConnectionSecret --> SQLProviderConfig
    Database --> AtlasSchema
```