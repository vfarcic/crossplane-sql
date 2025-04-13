# dot-sql

```yaml
---
apiVersion: devopstoolkit.live/v1alpha1
kind: SQLClaim
metadata:
  name: my-db
spec:
  id: my-db
  compositionSelector:
    matchLabels:
      provider: upcloud
      db: postgresql
  parameters:
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
```

```mermaid
flowchart TD
    classDef compositeResource fill:#3498db,color:white
    classDef upcloudResource fill:#D35400,color:white
    classDef otherResource fill:#8E44AD,color:white

    SQL["SQL<br>my-db"]:::compositeResource
    
    %% UpCloud Resources
    Router["Router<br>my-db"]:::upcloudResource
    Network["Network<br>my-db"]:::upcloudResource
    ManagedDatabasePostgresql["ManagedDatabasePostgresql<br>my-db"]:::upcloudResource
    
    %% Provider Resources
    KProviderConfig["ProviderConfig<br>my-db-sql-kubernetes"]:::otherResource
    HProviderConfig["ProviderConfig<br>my-db-sql-helm"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>my-db"]:::otherResource
    
    %% Database Resources
    Database["Database<br>my-db-main"]:::otherResource
    
    %% Secret Resources
    ConnectionSecret["Object<br>my-db-secret"]:::otherResource
    PasswordSecret["Secret<br>my-db-password"]:::otherResource
    
    %% Schema Resources
    SchemaObject["Object<br>my-db-schema-main"]:::otherResource
    
    %% Resource Relationships
    SQL --> Router
    SQL --> KProviderConfig
    SQL --> HProviderConfig
    SQL --> SQLProviderConfig
    
    Router --> Network
    Network --> ManagedDatabasePostgresql
    
    SQLProviderConfig --> Database
    
    ManagedDatabasePostgresql --> PasswordSecret
    ManagedDatabasePostgresql --> ConnectionSecret
    
    PasswordSecret --> ConnectionSecret
    
    ConnectionSecret --> SchemaObject
```