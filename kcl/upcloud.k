oxr = option("params").oxr
ocds = option("params").ocds

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace
_region = "us-nyc1"
if oxr.spec?.region:
    _region = oxr.spec.region
_address = "10.0.0.0/24"
if oxr.spec?.upcloud?.networkAddress:
    _address = oxr.spec.upcloud.networkAddress

_metadata = lambda resourceName: str -> any {
    {
        name = _name
        annotations = {
            "krm.kcl.dev/composition-resource-name" = resourceName
        }
    }
}

_items = [{
    apiVersion = "network.upcloud.com/v1alpha1"
    kind = "Router"
    metadata = _metadata("router")
    spec = {
        forProvider = {
            labels = {}
            name = _name
            staticRoute: []
        }
    }
}, {
    apiVersion = "network.upcloud.com/v1alpha1"
    kind = "Network"
    metadata = _metadata("network")
    spec.forProvider = {
        ipNetwork = [{
            address = _address
            dhcp = True
            dhcpDefaultRoute = False
            family = "IPv4"
        }]
        name = _name
        routerSelector.matchControllerRef = True
        zone = _region
    }
}, {
    apiVersion = "database.upcloud.com/v1alpha1"
    kind = "ManagedDatabasePostgresql"
    metadata = _metadata("manageddatabasepostgresql")
    spec = {
        forProvider = {
            name = _name
            network = [{
                family = "IPv4"
                name = _name
                type = "private"
                uuidSelector.matchControllerRef = True
            }]
            if oxr.spec.size == "small":
                plan = "1x1xCPU-2GB-25GB"
            elif oxr.spec.size == "medium":
                plan = "2x6xCPU-16GB-100GB"
            else:
                plan = "2x16xCPU-64GB-1000GB"
            title: _name
            zone: _region
            properties = [{
                publicAccess = True
                ipFilter = ["0.0.0.0/0"]
            }]
        }
        writeConnectionSecretToRef = {
            name = _name + "-password"
            namespace = _namespace
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
                apiVersion = "v1"
                kind = "Secret"
                name = _name + "-password"
                namespace = _namespace
                fieldPath = "data[attribute.service_password]"
            }
            toFieldPath = "data.password"
        }]
        forProvider.manifest = {
            apiVersion = "v1"
            kind = "Secret"
            metadata = {
                name = _name
            }
            data = {
                port = "MTE1Njk="
                username = "dXBhZG1pbg=="
            }
            if "manageddatabasepostgresql" in ocds and ocds["manageddatabasepostgresql"]?.Resource?.status?.atProvider?.serviceHost:
                stringData.endpoint = "public-" + ocds["manageddatabasepostgresql"].Resource.status.atProvider.serviceHost
        }
        providerConfigRef.name = _name + "-sql"
    }
}, {
    **oxr
    if "manageddatabasepostgresql" in ocds:
        status.address = ocds["manageddatabasepostgresql"].Resource.status.atProvider.serviceHost
}]

items = _items
