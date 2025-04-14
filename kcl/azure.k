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
            version = oxr.spec.version
            if oxr.spec.size == "small":
                skuName = "B_Gen5_1"
            elif oxr.spec.size == "medium":
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
                name = _name + "-password"
                key = "password"
                namespace: _namespace
            }
            publicNetworkAccessEnabled = True
        }
        writeConnectionSecretToRef = {
            name = _name
            namespace = _namespace
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
# }, {
#     apiVersion = "postgresql.sql.crossplane.io/v1alpha1"
#     kind = "ProviderConfig"
#     metadata = {
#         name = _name
#         annotations = {
#             "krm.kcl.dev/ready": "True"
#             "krm.kcl.dev/composition-resource-name" = "sql-config"
#         }
#     }
#     spec = {
#         credentials = {
#             source = "PostgreSQLConnectionSecret"
#             connectionSecretRef = {
#                 name = _name
#             }
#         }
#         sslMode = "require"
#     }
}, {
    **oxr
    if "server" in ocds:
        status.address = ocds["server"].Resource.status.atProvider.fqdn
}]

items = _items
