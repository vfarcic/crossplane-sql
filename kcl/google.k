oxr = option("params").oxr
ocds = option("params").ocds

_metadata = lambda resourceName: str -> any {
    {
        name = oxr.spec.id
        annotations = {
            # "crossplane.io/external-name" = oxr.spec.id
            "krm.kcl.dev/composition-resource-name" = resourceName
        }
    }
}

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
#   - functionRef:
#       name: crossplane-contrib-function-go-templating
#     step: schema
#     input:
#       apiVersion: gotemplating.fn.crossplane.io/v1beta1
#       kind: GoTemplate
#       source: Inline
#       delims:
#         left: '{{'
#         right: '}}'
#       inline:
#         template: |-
#           {{ range .observed.composite.resource.spec.parameters.schemas }}
#           ---
#           apiVersion: kubernetes.crossplane.io/v1alpha2
#           kind: Object
#           metadata:
#             name: {{ $.observed.composite.resource.spec.id }}-schema-{{ .database }}
#             annotations:
#               gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-schema-{{ .database }}
#           spec:
#             providerConfigRef:
#               name: {{ $.observed.composite.resource.spec.id }}-sql
#             forProvider:
#               manifest:
#                 apiVersion: db.atlasgo.io/v1alpha1
#                 kind: AtlasSchema
#                 metadata:
#                   name: {{ $.observed.composite.resource.spec.id }}-{{ .database }}
#                   namespace: {{ $.observed.composite.resource.spec.claimRef.namespace }}
#                 toFieldPath: spec.credentials.connectionSecretRef.namespace
#                 spec:
#                   credentials:
#                     scheme: postgres
#                     hostFrom:
#                       secretKeyRef:
#                         key: endpoint
#                         name: {{ $.observed.composite.resource.spec.id }}
#                     port: 5432
#                     userFrom:
#                       secretKeyRef:
#                         key: username
#                         name: {{ $.observed.composite.resource.spec.id }}
#                     passwordFrom:
#                       secretKeyRef:
#                         key: password
#                         name: {{ $.observed.composite.resource.spec.id }}
#                     database: {{ .database }}
#                     parameters:
#                       sslmode: disable
#                   schema: 
#                     sql: "{{ .sql }}"
#           {{ end }}
#   - functionRef:
#       name: crossplane-contrib-function-go-templating
#     step: secret-pull-cluster
#     input:
#       apiVersion: gotemplating.fn.crossplane.io/v1beta1
#       kind: GoTemplate
#       source: Inline
#       delims:
#         left: '{{'
#         right: '}}'
#       inline:
#         template: |-
#           {{ if and .observed.composite.resource.spec.parameters.secrets.storeName .observed.composite.resource.spec.parameters.secrets.pullToCluster }}
#           ---
#           apiVersion: kubernetes.crossplane.io/v1alpha2
#           kind: Object
#           metadata:
#             name: {{ $.observed.composite.resource.spec.id }}-secret-pull-cluster
#             annotations:
#               gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-secret-pull-cluster
#           spec:
#             providerConfigRef:
#               name: {{ $.observed.composite.resource.spec.parameters.secrets.pullToCluster }}
#             forProvider:
#               manifest:
#                 metadata:
#                   name: {{ $.observed.composite.resource.spec.id }}
#                   namespace: {{ $.observed.composite.resource.spec.parameters.secrets.pullToClusterNamespace }}
#                 apiVersion: external-secrets.io/v1beta1
#                 kind: ExternalSecret
#                 spec:
#                   dataFrom:
#                   - extract:
#                       conversionStrategy: Default
#                       decodingStrategy: None
#                       key: {{ $.observed.composite.resource.spec.id }}
#                       metadataPolicy: None
#                   refreshInterval: 1h
#                   secretStoreRef:
#                     kind: ClusterSecretStore
#                     name: {{ $.observed.composite.resource.spec.parameters.secrets.storeName }}
#                   target:
#                     creationPolicy: Owner
#                     deletionPolicy: Retain
#                     name: {{ $.observed.composite.resource.spec.id }}
#           {{ end }}
#   - functionRef:
#       name: crossplane-contrib-function-go-templating
#     step: dapr-components
#     input:
#       apiVersion: gotemplating.fn.crossplane.io/v1beta1
#       kind: GoTemplate
#       source: Inline
#       delims:
#         left: '{{'
#         right: '}}'
#       inline:
#         template: |-
#           {{ if and .observed.composite.resource.spec.parameters.secrets.daprComponents .observed.composite.resource.spec.parameters.secrets.pullToCluster }}
#           {{ range .observed.composite.resource.spec.parameters.databases }}
#           ---
#           apiVersion: kubernetes.crossplane.io/v1alpha2
#           kind: Object
#           metadata:
#             name: {{ $.observed.composite.resource.spec.id }}-dapr-component-{{ . }}
#             annotations:
#               gotemplating.fn.crossplane.io/composition-resource-name: {{ $.observed.composite.resource.spec.id }}-dapr-component-{{ . }}
#           spec:
#             providerConfigRef:
#               name: {{ $.observed.composite.resource.spec.parameters.secrets.pullToCluster }}
#             forProvider:
#               manifest:
#                 apiVersion: dapr.io/v1alpha1
#                 kind: Component
#                 metadata:
#                   name: {{ $.observed.composite.resource.spec.id }}-{{ . }}
#                   namespace: {{ $.observed.composite.resource.spec.parameters.secrets.pullToClusterNamespace }}
#                 spec:
#                   type: state.postgresql
#                   version: v1
#                   metadata:
#                     - name: connectionString
#                       secretKeyRef:
#                         name: {{ $.observed.composite.resource.spec.id }}
#                         key: conn-{{ . }}
#           {{ end }}
#           {{ end }}
#   - functionRef:
#       name: crossplane-contrib-function-go-templating
#     step: dynatrace
#     input:
#       apiVersion: gotemplating.fn.crossplane.io/v1beta1
#       kind: GoTemplate
#       source: Inline
#       delims:
#         left: '{{'
#         right: '}}'
#       inline:
#         template: |-
#           {{ if .observed.composite.resource.spec.parameters.dynatraceDashboard.enabled }}
#           ---
#           apiVersion: helm.crossplane.io/v1beta1
#           kind: Release
#           metadata:
#             name: {{ .observed.composite.resource.spec.id }}-dynatrace-dashboard
#             annotations:
#               gotemplating.fn.crossplane.io/composition-resource-name: {{ .observed.composite.resource.spec.id }}-dynatrace-dashboard
#           spec:
#             providerConfigRef:
#               name: {{ $.observed.composite.resource.spec.parameters.dynatraceDashboard.cluster }}
#             forProvider:
#               chart:
#                 name: kubernetes-workload
#                 repository: https://katharinasick.github.io/crossplane-observability-demo-dynatrace
#                 version: "0.1.5"
#               values:
#                 oauthCredentialsSecretName: {{ .observed.composite.resource.spec.parameters.dynatraceDashboard.oathCredentialsSecretName }}
#                 dashboard:
#                   enabled: true
#                 alerting:
#                   enabled: true
#                   slackChannel: "#{{ .observed.composite.resource.spec.parameters.dynatraceDashboard.slackChannel }}"
#                 workloadName: {{ .observed.composite.resource.spec.parameters.dynatraceDashboard.appDeploymentName }}
#                 cluster: {{ .observed.composite.resource.spec.parameters.dynatraceDashboard.cluster }}
#                 namespace: {{ .observed.composite.resource.spec.parameters.dynatraceDashboard.appNamespace }}
#                 crossplaneTerraformProvider:
#                   connectionSecretRef:
#                     name: dynatrace-terraform-creds
#                   namespace: crossplane-system
#                   key: credentials
#                 databaseAddress: {{ .observed.composite.resource.status.address }}
#               namespace: dynatrace
#             providerConfigRef:
#               name: {{ .observed.composite.resource.spec.id }}-sql
#             rollbackLimit: 3
#           {{ end }}
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

items = _items
