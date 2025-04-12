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

%% Style definitions
classDef blue fill:#1e88e5,color:white
classDef orange fill:#ff9800,color:white
classDef yellow fill:#ffc107,color:black

%% Composite Resource
SQL["SQL<br>my-db"]
class SQL blue

%% AWS Resources - Main Infrastructure
VPC["VPC<br>my-db"]
IGW["InternetGateway<br>my-db"]
RouteTable["RouteTable<br>my-db"]
Route["Route<br>my-db"]
SecurityGroup["SecurityGroup<br>my-db"]
SecurityGroupRule["SecurityGroupRule<br>my-db"]
MainRouteTableAssociation["MainRouteTableAssociation<br>my-db"]

%% AWS Resources - Subnets
SubnetA["Subnet<br>my-db-a"]
SubnetB["Subnet<br>my-db-b"]
SubnetC["Subnet<br>my-db-c"]

%% AWS Resources - Route Associations
RouteTableAssocA["RouteTableAssociation<br>my-db-1a"]
RouteTableAssocB["RouteTableAssociation<br>my-db-1b"]
RouteTableAssocC["RouteTableAssociation<br>my-db-1c"]

%% AWS Resources - Database
SubnetGroup["SubnetGroup<br>my-db"]
RDSInstance["Instance<br>my-db"]

%% Non-AWS Resources - Providers
KubernetesProviderConfig["ProviderConfig<br>my-db-sql"]
PostgreSQLProviderConfig["ProviderConfig<br>my-db"]

%% Non-AWS Resources - Database and Schema
PostgreSQLDatabase["Database<br>my-db-main"]
AtlasSchema["AtlasSchema<br>my-db-main"]

%% Non-AWS Resources - Secrets
ExternalSecretPassword["ExternalSecret<br>my-db-password"]
PushSecret["PushSecret<br>my-db"]
K8sObject["Object<br>my-db-secret"]

%% Main resource hierarchy
SQL --> VPC
SQL --> KubernetesProviderConfig
SQL --> PostgreSQLProviderConfig
SQL --> ExternalSecretPassword
SQL --> PushSecret

%% VPC and networking resources
VPC --> IGW
VPC --> RouteTable
VPC --> SecurityGroup
VPC --> MainRouteTableAssociation
VPC --> SubnetA
VPC --> SubnetB
VPC --> SubnetC

RouteTable --> Route
RouteTable --> RouteTableAssocA
RouteTable --> RouteTableAssocB
RouteTable --> RouteTableAssocC

IGW --> Route

SubnetA --> RouteTableAssocA
SubnetB --> RouteTableAssocB
SubnetC --> RouteTableAssocC

%% RDS and Subnet relationships
SubnetA --> SubnetGroup
SubnetB --> SubnetGroup
SubnetC --> SubnetGroup

SecurityGroup --> SecurityGroupRule
SecurityGroup --> RDSInstance
SubnetGroup --> RDSInstance

%% Database objects relationships
PostgreSQLProviderConfig --> PostgreSQLDatabase
PostgreSQLProviderConfig --> AtlasSchema

%% Secret management
RDSInstance --> K8sObject
ExternalSecretPassword --> K8sObject
RDSInstance --> PushSecret

%% Apply styles
class VPC,IGW,RouteTable,MainRouteTableAssociation,Route,SecurityGroup,SecurityGroupRule,SubnetA,SubnetB,SubnetC,RouteTableAssocA,RouteTableAssocB,RouteTableAssocC,SubnetGroup,RDSInstance orange
class KubernetesProviderConfig,PostgreSQLProviderConfig,PostgreSQLDatabase,ExternalSecretPassword,PushSecret,AtlasSchema,K8sObject yellow
```