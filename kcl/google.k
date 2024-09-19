oxr = option("params").oxr
ocds = option("params").ocds

_region = "us-east1"
if oxr.spec?.parameters?.region:
    _region = oxr.spec.parameters.region

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
    metadata = _metadata("databaseinstance")
    spec = {
        forProvider = {
            region = _region
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
    if "databaseinstance" in ocds:
        status.address = ocds["databaseinstance"].Resource.status.atProvider.publicIpAddress
}]

items = _items
