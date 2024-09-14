oxr = option("params").oxr
ocds = option("params").ocds

_metadata = lambda resourceName: str -> any {
    {
        name = oxr.spec.id
        annotations = {
            "krm.kcl.dev/composition-resource-name" = resourceName
        }
    }
}

_items = [{
    apiVersion = "sql.gcp.upbound.io/v1beta1"
    kind = "DatabaseInstance"
    metadata = _metadata("sql")
    spec = {
        forProvider = {
            region = "us-east1"
            databaseVersion = "POSTGRES_" + oxr.spec.parameters.version
            rootPasswordSecretRef = {
                name = oxr.spec.id + "-password"
                namespace = oxr.spec.claimRef.namespace
                key = "password"
            }
            settings = [{
                if oxr.spec.parameters.size == "small":
                    tier = "db-custom-1-3840"
                elif oxr.spec.parameters.size == "medium":
                    tier = "db-custom-16-61440"
                else:
                    tier = "db-custom-64-245760"
                availabilityType = "REGIONAL"
                backupConfiguration = [{
                    enabled = True
                    binaryLogEnabled = False
                }]
                ipConfiguration = [{
                    ipv4Enabled = True
                    authorizedNetworks = [{
                        name = "all"
                        value = "0.0.0.0/0"
                    }]
                }]
            }]
            deletionProtection = False
        }
    }
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
}, {
    apiVersion = "sql.gcp.upbound.io/v1beta1"
    kind = "User"
    metadata = _metadata("user")
    spec = {
        deletionPolicy = "Orphan"
        forProvider = {
          passwordSecretRef = {
             key = "password"
             name = oxr.spec.id + "-password"
            namespace = oxr.spec.claimRef.namespace
          }
          instanceSelector.matchControllerRef = True
        }
    }
}, {
    apiVersion = "kubernetes.crossplane.io/v1alpha2"
    kind = "Object"
    metadata = {
        name = oxr.spec.id + "-secret"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = "sql-secret"
        }
    }
    spec = {
        references = [{
            patchesFrom = {
                apiVersion = "sql.gcp.upbound.io/v1beta1"
                kind = "User"
                name = oxr.spec.id
                namespace = "crossplane-system"
                fieldPath = "metadata.name"
            }
            toFieldPath = "stringData.username"
        }, {
            patchesFrom = {
                apiVersion = "v1"
                kind = "Secret"
                name = oxr.spec.id + "-password"
                namespace = oxr.spec.claimRef.namespace
                fieldPath = "data.password"
            }
            toFieldPath = "data.password"
        }, {
            patchesFrom = {
                apiVersion = "sql.gcp.upbound.io/v1beta1"
                kind = "DatabaseInstance"
                name = oxr.spec.id
                namespace = "crossplane-system"
                fieldPath = "status.atProvider.publicIpAddress"
            }
            toFieldPath = "stringData.endpoint"
        }]
        forProvider.manifest = {
            apiVersion = "v1"
            kind = "Secret"
            metadata = {
                name = oxr.spec.id
                namespace = oxr.spec.claimRef.namespace
            }
            data.port = "NTQzMg=="
        }
        providerConfigRef.name = oxr.spec.id + "-sql"
    }
}, {
    **oxr
    if oxr.spec.id + "-sql" in ocds:
        status.address = ocds[oxr.spec.id + "-sql"].Resource.status.atProvider.publicIpAddress
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
                            name: oxr.spec.id
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

items = _items
