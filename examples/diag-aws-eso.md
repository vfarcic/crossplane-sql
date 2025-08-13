# dot-sql

```yaml
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
