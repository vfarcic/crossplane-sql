oxr = option("params").oxr
ocds = option("params").ocds

_region = "us-nyc1"
if oxr.spec?.parameters?.region:
    _region = oxr.spec.parameters.region
_address = "10.0.0.0/24"
if oxr.spec?.parameters?.upcloud?.networkAddress:
    _address = oxr.spec.parameters.upcloud.networkAddress

_metadata = lambda resourceName: str -> any {
    {
        name = oxr.spec.id
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
            name = oxr.spec.id
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
        name = oxr.spec.id
        routerSelector.matchControllerRef = True
        zone = _region
    }
}, {
    apiVersion = "database.upcloud.com/v1alpha1"
    kind = "ManagedDatabasePostgresql"
    metadata = _metadata("manageddatabasepostgresql")
    spec = {
        forProvider = {
            name = oxr.spec.id
            network = [{
                family = "IPv4"
                name = oxr.spec.id
                type = "private"
                uuidSelector.matchControllerRef = True
            }]
            if oxr.spec.parameters.size == "small":
                plan = "1x1xCPU-2GB-25GB"
            elif oxr.spec.parameters.size == "medium":
                plan = "2x6xCPU-16GB-100GB"
            else:
                plan = "2x16xCPU-64GB-1000GB"
            title: oxr.spec.id
            zone: _region
            properties = [{
                publicAccess = True
                ipFilter = ["0.0.0.0/0"]
            }]
        }
        writeConnectionSecretToRef = {
            name = oxr.spec.id + "-password"
            namespace = oxr.spec.claimRef.namespace
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
                apiVersion = "v1"
                kind = "Secret"
                name = oxr.spec.id + "-password"
                namespace = oxr.spec.claimRef.namespace
                fieldPath = "data[attribute.service_password]"
            }
            toFieldPath = "data.password"
        }]
        forProvider.manifest = {
            apiVersion = "v1"
            kind = "Secret"
            metadata = {
                name = oxr.spec.id
                namespace = oxr.spec.claimRef.namespace
            }
            data = {
                port = "MTE1Njk="
                username = "dXBhZG1pbg=="
            }
            if "manageddatabasepostgresql" in ocds and ocds["manageddatabasepostgresql"]?.Resource?.status?.atProvider?.serviceHost:
                stringData.endpoint = "public-" + ocds["manageddatabasepostgresql"].Resource.status.atProvider.serviceHost
        }
        providerConfigRef.name = oxr.spec.id + "-sql"
    }
}, {
    **oxr
    if "manageddatabasepostgresql" in ocds:
        status.address = ocds["manageddatabasepostgresql"].Resource.status.atProvider.serviceHost
}]

items = _items
