oxr = option("params").oxr
ocds = option("params").ocds

_region = "eastus"
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
    apiVersion = "azure.upbound.io/v1beta1"
    kind = "ResourceGroup"
    metadata = _metadata("resourcegroup")
    spec.forProvider.location = _region
}, {
    apiVersion = "dbforpostgresql.azure.upbound.io/v1beta1"
    kind = "Server"
    metadata = _metadata("server")
    spec = {
        forProvider = {
            location = _region
            version = oxr.spec.parameters.version
            if oxr.spec.parameters.size == "small":
                skuName = "B_Gen5_1"
            elif oxr.spec.parameters.size == "medium":
                skuName = "GP_Gen5_2"
            else:
                skuName = "GP_Gen5_8"
            resourceGroupNameSelector.matchControllerRef = True
            storageMb = 5120
            autoGrowEnabled = True
            sslEnforcementEnabled = False
            sslMinimalTlsVersionEnforced = "TLSEnforcementDisabled"
            administratorLogin = "postgres"
            administratorLoginPasswordSecretRef = {
                name = oxr.spec.id + "-password"
                key = "password"
                namespace = oxr.spec.claimRef.namespace
            }
            publicNetworkAccessEnabled = True
        }
        writeConnectionSecretToRef = {
            name = oxr.spec.id
            namespace = oxr.spec.claimRef.namespace
        }
    }
}, {
    apiVersion = "dbforpostgresql.azure.upbound.io/v1beta1"
    kind = "FirewallRule"
    metadata = _metadata("firewall-rule")
    spec.forProvider = {
        startIpAddress = "0.0.0.0"
        endIpAddress = "255.255.255.255"
        resourceGroupNameSelector.matchControllerRef = True
        serverNameSelector.matchControllerRef = True
    }
}, {
    apiVersion = "postgresql.sql.crossplane.io/v1alpha1"
    kind = "ProviderConfig"
    metadata = {
        name = oxr.spec.id
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = "sql-config"
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
    **oxr
    if "server" in ocds:
        status.address = ocds["server"].Resource.status.atProvider.fqdn
}]

items = _items
