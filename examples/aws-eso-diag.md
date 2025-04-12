# dot-sql

```yaml
---
apiVersion: devopstoolkit.live/v1beta1
kind: SQL
metadata:
  name: my-db
spec:
  version: "16.3"
  size: small
  region: us-east-1
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
    storeName: aws
    pullRootPasswordKey: db-root-password
    pushToStore: true
  crossplane:
    compositionSelector:
      matchLabels:
        provider: aws
        db: postgresql
```

```mermaid
graph TD
    %% Composite Resource
    A["SQL<br>my-db"]
    
    %% AWS Resources
    B["InternetGateway<br>my-db"]
    C["MainRouteTableAssociation<br>my-db"]
    D["RouteTable<br>my-db"]
    E["Route<br>my-db"]
    F["SecurityGroupRule<br>my-db"]
    G["SecurityGroup<br>my-db"]
    H["VPC<br>my-db"]
    I["SubnetGroup<br>my-db"]
    J["Instance<br>my-db"]
    
    %% Subnets & Route Table Associations
    K1["Subnet<br>my-db-a"]
    K2["Subnet<br>my-db-b"]
    K3["Subnet<br>my-db-c"]
    L1["RouteTableAssociation<br>my-db-1a"]
    L2["RouteTableAssociation<br>my-db-1b"]
    L3["RouteTableAssociation<br>my-db-1c"]
    
    %% Other Resources
    M["Object<br>my-db-secret"]
    N["ProviderConfig<br>my-db-sql"]
    O["ProviderConfig<br>my-db"]
    P["Database<br>my-db-main"]
    Q["ExternalSecret<br>my-db-password"]
    R["PushSecret<br>my-db"]
    S["AtlasSchema<br>my-db-main"]

    %% Relationships - only showing parent-child relationships
    A --> H
    A --> N
    A --> O
    A --> Q
    A --> R
    
    %% Resources with matchControllerRef
    H --> B
    H --> C
    H --> D
    H --> G
    H --> K1
    H --> K2
    H --> K3
    
    G --> F
    
    D --> C
    D --> E
    D --> L1
    D --> L2
    D --> L3
    
    K1 --> I
    K2 --> I
    K3 --> I
    
    I --> J
    G --> J
    
    %% Other specific relationships
    B --> E
    
    K1 --> L1
    K2 --> L2
    K3 --> L3
    
    %% Functional relationships
    O --> P
    P --> S
    Q --> R
    J --> M

    %% Styling
    style A fill:#2374f7,stroke:#000,stroke-width:1px,color:white
    
    %% AWS resources (orange)
    style B fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style C fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style D fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style E fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style F fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style G fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style H fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style I fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style J fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style K1 fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style K2 fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style K3 fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style L1 fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style L2 fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    style L3 fill:#ff7e33,stroke:#000,stroke-width:1px,color:white
    
    %% Other resources (yellow)
    style M fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
    style N fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
    style O fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
    style P fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
    style Q fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
    style R fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
    style S fill:#ffcc00,stroke:#000,stroke-width:1px,color:black
```