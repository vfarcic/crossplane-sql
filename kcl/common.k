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
# TODO: Uncomment when `postgresql.sql.crossplane.io` is adapted to v2 # }, {
#     apiVersion = "postgresql.sql.crossplane.io/v1alpha1"
#     kind = "ProviderConfig"
#     metadata = {
#         name = _name
#         annotations = {
#             "krm.kcl.dev/ready": "True"
#             "krm.kcl.dev/composition-resource-name" = "sql-config"
#             "crossplane.io/external-name" = "default"
#         }
#     }
#     spec = {
#         credentials = {
#           source = "PostgreSQLConnectionSecret"
#           connectionSecretRef = {
#             name = _name
#             namespace = _namespace
#           }
#         }
#         if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "upcloud":
#             defaultDatabase = "defaultdb"
#         sslMode = "require"
#     }
}]

# if oxr.spec?.databases:
#     _items += [{
#         apiVersion = "postgresql.sql.crossplane.io/v1alpha1"
#         kind = "Database"
#         metadata = {
#             name = _name + "-" + _database
#             annotations = {
#                 "crossplane.io/external-name" = _database
#                 "krm.kcl.dev/composition-resource-name" = _name + "-" + _database
#             }
#         }
#         spec = {
#             providerConfigRef.name = _name
#             forProvider = {}
#             deletionPolicy = "Orphan"
#         }
#     } for _database in oxr.spec.databases ]

if oxr.spec.secrets?.storeName and oxr.spec.secrets?.pullRootPasswordKey:
    _items += [{
        apiVersion = "external-secrets.io/v1"
        kind = "ExternalSecret"
        metadata = {
            name = _name + "-password"
            annotations = {
                "krm.kcl.dev/ready" = "True"
                "krm.kcl.dev/composition-resource-name" = _name + "-secret-pull"
            }
        }
        spec = {
            dataFrom = [{
                extract = {
                    conversionStrategy = "Default"
                    decodingStrategy = "None"
                    key = oxr.spec.secrets.pullRootPasswordKey
                    metadataPolicy = "None"
                }
            }]
            refreshInterval = "1h"
            secretStoreRef = {
                kind = "ClusterSecretStore"
                name = oxr.spec.secrets.storeName
            }
            target = {
                creationPolicy = "Owner"
                deletionPolicy = "Retain"
                name = _name + "-password"
            }
        }
    }]

if oxr.spec.secrets?.storeName and oxr.spec.secrets?.pushToStore:
    _endpoint = """\
{
  "endpoint": "{{ .endpoint }}",
  "port": "{{ .port }}",
  "username": "{{ .username }}",
  "password": "{{ .password }}",
  """
    _conns = [ "\"conn-{}\": \"host=[[ .endpoint ]] user=[[ .username ]] password=[[ .password ]] port=[[ .port ]] connect_timeout=10 database={}\"".format(_db, _db).replace("[[", "{{").replace("]]", "}}") for _db in oxr.spec.databases ]
    _endpoint += ",\n  ".join(_conns)
    _endpoint += """
}
"""
    _items += [{
        apiVersion = "external-secrets.io/v1alpha1"
        kind = "PushSecret"
        metadata = {
            name = _name
            annotations = {
                "krm.kcl.dev/ready" = "True"
                "krm.kcl.dev/composition-resource-name" = _name + "-secret-push-store"
            }
        }
        spec = {
            refreshInterval = "1h"
            secretStoreRefs = [{
                name = oxr.spec.secrets.storeName
                kind = "ClusterSecretStore"
            }]
            selector.secret.name = _name
            template.data.endpoint = _endpoint
            data = [{
                match = {
                    secretKey = "endpoint"
                    remoteRef.remoteKey = _name
                }
            }]
            deletionPolicy = "Delete"
        }
    }]

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
                if oxr.spec.crossplane.compositionSelector.matchLabels.provider == "upcloud":
                    port = 11569
                if oxr.spec.crossplane.compositionSelector.matchLabels.provider != "upcloud":
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

if oxr.spec.secrets?.pullToCluster:
    _items += [{
        apiVersion = "external-secrets.io/v1"
        kind = "ExternalSecret"
        metadata = {
            name = _name
            annotations = {
                "krm.kcl.dev/ready" = "True"
                "krm.kcl.dev/composition-resource-name" = _name + "-secret-pull-cluster"
            }
            namespace = oxr.spec.secrets.pullToClusterNamespace
        }
        spec = {
            dataFrom = [{
                extract = {
                    conversionStrategy = "Default"
                    decodingStrategy = "None"
                    key = _name
                    metadataPolicy = "None"
                }
            }]
            refreshInterval = "1h"
            secretStoreRef = {
                kind = "ClusterSecretStore"
                name = oxr.spec.secrets.storeName
            }
            target = {
                creationPolicy = "Owner"
                deletionPolicy = "Retain"
                name = _name
            }
        }
    }]

items = _items
