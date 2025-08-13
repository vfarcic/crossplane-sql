oxr = option("params").oxr
ocds = option("params").ocds

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace
_region = "eastus"
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
    apiVersion = "resources.azure.com/v1api20200601"
    kind = "ResourceGroup"
    metadata = _metadata("resourcegroup")
    spec.location = _region
}, {
    apiVersion = "dbforpostgresql.azure.com/v1api20221201"
    kind = "FlexibleServer"
    metadata = _metadata("server")
    spec = {
        location = _region
        version = oxr.spec.version
        if oxr.spec.size == "small":
            sku.name = "Standard_D2ds_v4"
        elif oxr.spec.size == "medium":
            sku.name = "Standard_D8ds_v4"
        else:
            sku.name = "Standard_D32ds_v4"
        sku.tier = "GeneralPurpose"
        owner.name = _name
        storage.storageSizeGB = 128
        administratorLogin = "postgres"
        administratorLoginPassword = {
            name = _name + "-password"
            key = "password"
        }
    }
}, {
    apiVersion = "dbforpostgresql.azure.com/v1api20221201"
    kind = "FlexibleServersFirewallRule"
    metadata = _metadata("firewall-rule")
    spec = {
        startIpAddress = "0.0.0.0"
        endIpAddress = "255.255.255.255"
        owner.name = _name
        azureName = _name
    }
}, {
    apiVersion = "kubernetes.m.crossplane.io/v1alpha1"
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
                apiVersion = "dbforpostgresql.azure.com/v1api20221201"
                kind = "FlexibleServer"
                name = _name
                namespace = _namespace
                fieldPath = "status.administratorLogin"
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
                apiVersion = "dbforpostgresql.azure.com/v1api20221201"
                kind = "FlexibleServer"
                name = _name
                namespace = _namespace
                fieldPath = "status.fullyQualifiedDomainName"
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
        providerConfigRef = {
            name = _name + "-sql"
            kind = "ProviderConfig"
        }
    }
}, {
    **oxr
    if "server" in ocds:
        status.address = ocds["server"].Resource.status.fullyQualifiedDomainName
}]

items = _items
