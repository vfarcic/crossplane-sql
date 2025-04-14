oxr = option("params").oxr
ocds = option("params").ocds

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace

_metadata = lambda resourceName: str -> any {
    {
        name = _name
        annotations = {
            "krm.kcl.dev/composition-resource-name" = resourceName
        }
    }
}

_items = [{
    apiVersion = "postgresql.cnpg.io/v1"
    kind = "Cluster"
    metadata = _metadata("cluster")
    spec = {
        if oxr.spec.size == "small":
            instances = 1
            storage.size = "1Gi"
        elif oxr.spec.size == "medium":
            instances = 3
            storage.size = "3Gi"
        else:
            instances = 6
            storage.size = "6Gi"
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
                apiVersion = "v1"
                kind = "Secret"
                name = "{}-app".format(_name)
                namespace = _namespace
                fieldPath = "data.password"
            }
            toFieldPath = "data.password"
        }]
        forProvider.manifest = {
            apiVersion = "v1"
            kind = "Secret"
            metadata = {
                name = _name
                namespace = _namespace
            }
            data = {
                port = "NTQzMg=="
                username = "YXBw"
            }
            stringData.endpoint = "{}-rw".format(_name)
        }
        providerConfigRef.name = _name + "-sql"
    }
# }, {
#     **oxr
#     if "cluster" in ocds:
#         status.address = ocds["cluster"].Resource.status.atProvider.serviceHost
}]

items = _items
