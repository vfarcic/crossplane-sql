oxr = option("params").oxr
ocds = option("params").ocds

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace
_region = "us-east1"
if oxr.spec?.region:
    _region = oxr.spec.region

_metadata = lambda resourceName: str -> any {
    {
        name = _name
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
            databaseVersion = "POSTGRES_" + oxr.spec.version
            rootPasswordSecretRef = {
                name = _name + "-password"
                key = "password"
                namespace = _namespace
            }
            settings = [{
                if oxr.spec.size == "small":
                    tier = "db-custom-1-3840"
                elif oxr.spec.size == "medium":
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
                name = _name + "-password"
                namespace = _namespace
            }
            instanceSelector.matchControllerRef = True
        }
    }
}, {
    apiVersion = "kubernetes.crossplane.io/v1alpha2"
    kind = "Object"
    metadata = {
        name = _name + "-secret"
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
                name = _name
                namespace = "crossplane-system"
                fieldPath = "metadata.name"
            }
            toFieldPath = "stringData.username"
        }, {
            patchesFrom = {
                apiVersion = "v1"
                kind = "Secret"
                name = _name + "-password"
                namespace = _namespace
                fieldPath = "data.password"
            }
            toFieldPath = "data.password"
        }, {
            patchesFrom = {
                apiVersion = "sql.gcp.upbound.io/v1beta1"
                kind = "DatabaseInstance"
                name = _name
                namespace = "crossplane-system"
                fieldPath = "status.atProvider.publicIpAddress"
            }
            toFieldPath = "stringData.endpoint"
        }]
        forProvider.manifest = {
            apiVersion = "v1"
            kind = "Secret"
            metadata = {
                name = _name
                namespace = _namespace
            }
            data.port = "NTQzMg=="
        }
        providerConfigRef.name = _name + "-sql"
    }
}, {
    **oxr
    if "databaseinstance" in ocds:
        status.address = ocds["databaseinstance"].Resource.status.atProvider.publicIpAddress
}]

items = _items
