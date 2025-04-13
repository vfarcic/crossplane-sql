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
      provider: google
      db: postgresql
  parameters:
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
    
    %% Other Resources
    KProviderConfig["ProviderConfig<br>my-db-sql-kubernetes"]:::otherResource
    HProviderConfig["ProviderConfig<br>my-db-sql-helm"]:::otherResource
    SQLProviderConfig["ProviderConfig<br>my-db"]:::otherResource
    Database["Database<br>my-db-main"]:::otherResource
    ConnectionSecret["Object<br>my-db-secret"]:::otherResource
    PasswordSecret["Object<br>my-db-secret-pull"]:::otherResource
    PushSecret["Object<br>my-db-secret-push-store"]:::otherResource
    SchemaObject["Object<br>my-db-schema-main"]:::otherResource
    
    %% Resource Relationships
    SQL --> DatabaseInstance
    SQL --> KProviderConfig
    SQL --> HProviderConfig
    SQL --> SQLProviderConfig
    
    DatabaseInstance --> User
    DatabaseInstance --> ConnectionSecret
    User --> ConnectionSecret
    
    SQLProviderConfig --> Database
    
    PasswordSecret --> DatabaseInstance
    
    ConnectionSecret --> Database
    ConnectionSecret --> SchemaObject
    ConnectionSecret --> PushSecret
```