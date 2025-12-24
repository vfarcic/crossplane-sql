oxr = option("params").oxr

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace
schema providerConfig:
    _apiVersion: str
    _suffix: str
    apiVersion = _apiVersion
    kind = "ProviderConfig"
    metadata = {
        name = _name + "-sql"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = _name + "-provider-config-" + _suffix
        }
    }
    spec = {
        credentials.source = "InjectedIdentity"
    }

_items = [
    providerConfig {
        _apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
        _suffix = "kubernetes"
}, {
    apiVersion = "postgresql.sql.m.crossplane.io/v1alpha1"
    kind = "ProviderConfig"
    metadata = {
        name = _name
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = "sql-config"
            "crossplane.io/external-name" = "default"
        }
    }
    spec = {
        credentials = {
          source = "PostgreSQLConnectionSecret"
          connectionSecretRef.name = _name
        }
        sslMode = "require"
    }
}]

if oxr.spec?.databases:
    _items += [{
        apiVersion = "postgresql.sql.m.crossplane.io/v1alpha1"
        kind = "Database"
        metadata = {
            name = _name + "-" + _database
            annotations = {
                "crossplane.io/external-name" = _database
                "krm.kcl.dev/composition-resource-name" = _name + "-" + _database
            }
        }
        spec = {
            providerConfigRef = {
                name = _name
                kind = "ProviderConfig"
            }
            forProvider = {}
        }
    } for _database in oxr.spec.databases ]

if oxr.spec.schemas:
    _items += [{
        apiVersion = "db.atlasgo.io/v1alpha1"
        kind = "AtlasSchema"
        metadata = {
            name = _name + "-" + _schema.database
            annotations = {
                "krm.kcl.dev/ready" = "True"
                "krm.kcl.dev/composition-resource-name" = _name + "-schema-" + _schema.database
            }
        }
        spec = {
            credentials = {
                scheme = "postgres"
                hostFrom.secretKeyRef = {
                    key = "endpoint"
                    name = _name
                }
                port = 5432
                userFrom.secretKeyRef = {
                    key = "username"
                    name = _name
                }
                passwordFrom.secretKeyRef = {
                    key = "password"
                    name = _name
                }
                database = _schema.database
                parameters.sslmode = "require"
            }
            schema.sql = _schema.sql
        }
    } for _schema in oxr.spec.schemas ]

items = _items
