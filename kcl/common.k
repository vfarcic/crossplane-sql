oxr = option("params").oxr

schema providerConfig:
    _apiVersion: str
    _suffix: str
    apiVersion = _apiVersion
    kind = "ProviderConfig"
    metadata = {
        name = oxr.spec.id + "-sql"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-provider-config-" + _suffix
        }
    }
    spec = {
        credentials.source = "InjectedIdentity"
    }

_items = [
    providerConfig {
        _apiVersion = "kubernetes.crossplane.io/v1alpha1"
        _suffix = "kubernetes"
    },
    providerConfig {
        _apiVersion = "helm.crossplane.io/v1beta1"
        _suffix = "helm"
}, {
    apiVersion = "postgresql.sql.crossplane.io/v1alpha1"
    kind = "ProviderConfig"
    metadata = {
        name = oxr.spec.id
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = "sql-config"
            "crossplane.io/external-name" = "default"
        }
    }
    spec = {
        credentials = {
          source = "PostgreSQLConnectionSecret"
          connectionSecretRef = {
            name = oxr.spec.id
            namespace = oxr.spec.claimRef.namespace
          }
        }
        sslMode = "require"
    }
}]

if oxr.spec.parameters?.databases:
    _items += [{
        apiVersion = "postgresql.sql.crossplane.io/v1alpha1"
        kind = "Database"
        metadata = {
            name = oxr.spec.id + "-" + _database
            annotations = {
                "crossplane.io/external-name" = _database
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-" + _database
            }
        }
        spec = {
            providerConfigRef.name = oxr.spec.id
            forProvider = {}
        }
    } for _database in oxr.spec.parameters.databases ]
    if oxr.spec.parameters?.usage?.enabled:
        _items += [{
            apiVersion = "apiextensions.crossplane.io/v1alpha1"
            kind = "Usage"
            metadata = {
                name = oxr.spec.id + "-" + _database + "-usage"
                annotations = {
                    "krm.kcl.dev/ready": "True"
                    "crossplane.io/external-name" = oxr.spec.id + "-" + _database + "-usage"
                    "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-" + _database + "-usage"
                }
            }
            spec = {
                of = {
                    apiVersion = "SERVER_API_VERSION"
                    kind = "SERVER_KIND"
                    resourceRef.name = oxr.spec.id
                }
                by = {
                    kind = "Database"
                    resourceRef.name = oxr.spec.id + "-" + _database
                }
            }
        } for _database in oxr.spec.parameters.databases ]
    # xxx

if oxr.spec.parameters?.secrets?.storeName and oxr.spec.parameters?.secrets?.pullRootPasswordKey:
    _items += [{
        apiVersion = "kubernetes.crossplane.io/v1alpha2"
        kind = "Object"
        metadata = {
            name = oxr.spec.id + "-secret-pull"
            annotations = {
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-secret-pull"
            }
        }
        spec = {
            providerConfigRef.name = oxr.spec.id + "-sql"
            forProvider.manifest = {
                apiVersion = "external-secrets.io/v1beta1"
                kind = "ExternalSecret"
                metadata = {
                    name = oxr.spec.id + "-password"
                    namespace: oxr.spec.claimRef.namespace
                }
                spec = {
                    dataFrom = [{
                        extract = {
                            conversionStrategy = "Default"
                            decodingStrategy = "None"
                            key = oxr.spec.parameters.secrets.pullRootPasswordKey
                            metadataPolicy = "None"
                        }
                    }]
                    refreshInterval = "1h"
                    secretStoreRef = {
                        kind = "ClusterSecretStore"
                        name = oxr.spec.parameters.secrets.storeName
                    }
                    target = {
                        creationPolicy = "Owner"
                        deletionPolicy = "Retain"
                        name = oxr.spec.id + "-password"
                    }
                }
            }
        }
    }]

if oxr.spec.parameters?.secrets?.storeName and oxr.spec.parameters?.secrets?.pushToStore:
    _endpoint = """\
{
  "endpoint": "{{ .endpoint }}",
  "port": "{{ .port }}",
  "username": "{{ .username }}",
  "password": "{{ .password }}",
  """
    _conns = [ "\"conn-{}\": \"host=[[ .endpoint ]] user=[[ .username ]] password=[[ .password ]] port=[[ .port ]] connect_timeout=10 database={}\"".format(_db, _db).replace("[[", "{{").replace("]]", "}}") for _db in oxr.spec.parameters.databases ]
    _endpoint += ",\n  ".join(_conns)
    _endpoint += """
}
"""
    _items += [{
        apiVersion = "kubernetes.crossplane.io/v1alpha2"
        kind = "Object"
        metadata = {
            name = oxr.spec.id + "-secret-push-store"
            annotations = {
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-secret-push-store"
            }
        }
        spec = {
            providerConfigRef.name = oxr.spec.id + "-sql"
            forProvider.manifest = {
                apiVersion = "external-secrets.io/v1alpha1"
                kind = "PushSecret"
                metadata = {
                    name = oxr.spec.id
                    namespace: oxr.spec.claimRef.namespace
                }
                spec = {
                    deletionPolicy = "Delete"
                    refreshInterval = "1h"
                    secretStoreRefs = [{
                        name = oxr.spec.parameters.secrets.storeName
                        kind = "ClusterSecretStore"
                    }]
                    selector.secret.name = oxr.spec.id
                    template.data.endpoint = _endpoint
                    data = [{
                        match = {
                            secretKey = "endpoint"
                            remoteRef.remoteKey = oxr.spec.id
                        }
                    }]
                }
            }
        }
    }]

if oxr.spec.parameters?.schemas:
    _items += [{
        apiVersion = "kubernetes.crossplane.io/v1alpha2"
        kind = "Object"
        metadata = {
            name = oxr.spec.id + "-schema-" + _schema.database
            annotations = {
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-schema-" + _schema.database
            }
        }
        spec = {
            providerConfigRef.name = oxr.spec.id + "-sql"
            forProvider.manifest = {
                apiVersion = "db.atlasgo.io/v1alpha1"
                kind = "AtlasSchema"
                metadata = {
                    name = oxr.spec.id + "-" + _schema.database
                    namespace = oxr.spec.claimRef.namespace
                }
                toFieldPath = "spec.credentials.connectionSecretRef.namespace"
                spec = {
                    credentials = {
                        scheme = "postgres"
                        hostFrom.secretKeyRef = {
                            key = "endpoint"
                            name = oxr.spec.id
                        }
                        port = 5432
                        userFrom.secretKeyRef = {
                            key = "username"
                            name = oxr.spec.id
                        }
                        passwordFrom.secretKeyRef = {
                            key = "password"
                            name = oxr.spec.id
                        }
                        database = _schema.database
                        parameters.sslmode = "disable"
                    }
                    schema.sql = _schema.sql
                }
            }
        }
    } for _schema in oxr.spec.parameters.schemas ]

if oxr.spec.parameters?.secrets?.daprComponents and oxr.spec.parameters?.secrets?.pullToCluster:
    _items += [{
        apiVersion = "kubernetes.crossplane.io/v1alpha2"
        kind = "Object"
        metadata = {
            name = oxr.spec.id + "-dapr-component-" + _database
            annotations = {
                "crossplane.io/external-name" = oxr.spec.id + "-dapr-component-" + _database
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-dapr-component-" + _database
            }
        }
        spec = {
            providerConfigRef.name = oxr.spec.parameters.secrets.pullToCluster
            forProvider = {
                manifest = {
                    apiVersion = "dapr.io/v1alpha1"
                    kind = "Component"
                    metadata = {
                        name = oxr.spec.id + "-" + _database
                        namespace = oxr.spec.parameters.secrets.pullToClusterNamespace
                    }
                    spec = {
                        type = "state.postgresql"
                        version = "v1"
                        metadata = [{
                            name = "connectionString"
                            secretKeyRef = {
                                name = oxr.spec.id
                                key = "conn-" + _database
                            }
                        }]
                    }
                }
            }
        }
    } for _database in oxr.spec.parameters.databases ]
    _items += [{
        apiVersion = "kubernetes.crossplane.io/v1alpha2"
        kind = "Object"
        metadata = {
            name = oxr.spec.id + "-secret-pull-cluster"
            annotations = {
                "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-secret-pull-cluster"
            }
        }
        spec = {
            providerConfigRef.name = oxr.spec.parameters.secrets.pullToCluster
            forProvider.manifest = {
                apiVersion = "external-secrets.io/v1beta1"
                kind = "ExternalSecret"
                metadata = {
                    name = oxr.spec.id
                    namespace = oxr.spec.parameters.secrets.pullToClusterNamespace
                }
                spec = {
                    dataFrom = [{
                        extract = {
                            conversionStrategy = "Default"
                            decodingStrategy = "None"
                            key = oxr.spec.id
                            metadataPolicy = "None"
                        }
                    }]
                    refreshInterval = "1h"
                    secretStoreRef = {
                        kind = "ClusterSecretStore"
                        name = oxr.spec.parameters.secrets.storeName
                    }
                    target = {
                        creationPolicy = "Owner"
                        deletionPolicy = "Retain"
                        name = oxr.spec.id
                    }
                }
            }
        }
    }]

items = _items
