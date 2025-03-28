import models.io.crossplane.kubernetes.v1alpha2 as k8sv1alpha2

oxr = option("params").oxr
ocds = option("params").ocds

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace
_region = "us-east-1"
if oxr.spec?.region:
    _region = oxr.spec.region

_metadata = lambda resourceName: str -> any {
    _metadataSuffix(resourceName, "")
}
_metadataSuffix = lambda resourceName: str, nameSuffix: str -> any {
    {
        _fullName = _name
        if nameSuffix:
            _fullName = "{}-{}".format(_name, nameSuffix)
        name = _fullName
        annotations = {
            "krm.kcl.dev/composition-resource-name" = resourceName
            "services.k8s.aws/region" = _region
        }
    }
}
_tags = [{key = "name", value = _name}]

_zoneList = [
    { zone = "a", cidrBlock = "11.0.0.0/24" },
    { zone = "b", cidrBlock = "11.0.1.0/24"  },
    { zone = "c", cidrBlock = "11.0.2.0/24"  }
]

_items = [
    {
        apiVersion = "ec2.services.k8s.aws/v1alpha1"
        kind = "VPC"
        metadata =_metadata("vpc")
        spec = {
            cidrBlocks = ["11.0.0.0/16"]
            enableDNSSupport = True
            enableDNSHostnames = True
            tags = _tags
        }
    }, {
        apiVersion = "ec2.services.k8s.aws/v1alpha1"
        kind = "InternetGateway"
        metadata =_metadata("internetgateway")
        spec = {
            vpcRef.from.name = _name
            tags = _tags
        }
    }, {
        apiVersion = "ec2.services.k8s.aws/v1alpha1"
        kind = "RouteTable"
        metadata = _metadata("routetable")
        spec = {
            vpcRef.from.name = _name
            routes = [{
                destinationCIDRBlock = "0.0.0.0/0"
                gatewayRef.from.name = _name
            }]
            tags = _tags
        }
    }, {
        apiVersion = "ec2.services.k8s.aws/v1alpha1"
        kind = "SecurityGroup"
        metadata = _metadata("securitygroup")
        spec = {
            name = _name
            description = "I am too lazy to write descriptions"
            vpcRef.from.name = _name
            ingressRules = [{
                fromPort = 5432
                toPort = 5432
                ipProtocol = "tcp"
                ipRanges = [{
                    cidrIP = "0.0.0.0/0"
                    description = "I am too lazy to write descriptions"
                }]
            }]
            tags = _tags
        }
    }, {
        apiVersion = "rds.services.k8s.aws/v1alpha1"
        kind = "DBSubnetGroup"
        metadata = _metadata("dbsubnetgroup")
        spec = {
            name = _name
            description = "I am too lazy to write descriptions"
            subnetRefs = [
                {from.name = "{}-{}".format(_name, _data.zone)} for _data in _zoneList
            ]
        }
    }, {
        apiVersion = "rds.services.k8s.aws/v1alpha1"
        kind = "DBInstance"
        metadata = _metadata("dbinstance")
        spec = {
            dbSubnetGroupRef.from.name = _name
            vpcSecurityGroupRefs = [{from.name = _name}]
            masterUsername = "masteruser"
            engine = "postgres"
            # skipFinalSnapshot: true
            publiclyAccessible = True
            allocatedStorage = 200
            masterUserPassword = {
                key = "password"
                name = "{}-password".format(_name)
            }
            storageEncrypted = True
            dbInstanceIdentifier = _name
            if oxr.spec.size == "small":
                dbInstanceClass = "db.m5.large"
            elif oxr.spec.size == "medium":
                dbInstanceClass = "db.m5.2xlarge"
            else:
                dbInstanceClass = "db.m5.8xlarge"
            engineVersion = oxr.spec.version
        }
    },
    k8sv1alpha2.Object {
        metadata = {
            name = "{}-secret".format(_name)
            annotations = {
                "krm.kcl.dev/ready": "True"
                "krm.kcl.dev/composition-resource-name" = "sql-secret"
            }
        }
        spec = {
            references = [{
                patchesFrom = {
                    apiVersion = "rds.services.k8s.aws/v1alpha1"
                    kind = "DBInstance"
                    name = _name
                    namespace = _namespace
                    fieldPath = "spec.masterUsername"
                }
                toFieldPath = "stringData.username"
            }, {
                patchesFrom = {
                    apiVersion = "v1"
                    kind = "Secret"
                    name = "{}-password".format(_name)
                    namespace = _namespace
                    fieldPath = "data.password"
                }
                toFieldPath = "data.password"
            }, {
                patchesFrom = {
                    apiVersion = "rds.services.k8s.aws/v1alpha1"
                    kind = "DBInstance"
                    name = _name
                    namespace = _namespace
                    fieldPath = "status.endpoint.address"
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
    # }, {
    #     **oxr
    #     if "rdsinstance" in ocds:
    #         status.address = ocds["rdsinstance"].Resource.status.atProvider.address
    }
]

# _routeTableAssociations = [
#     {
#         apiVersion = "ec2.m.aws.upbound.io/v1beta1"
#         kind = "RouteTableAssociation"
#         metadata = {
#             name = _name + "-1" + _data.zone
#             annotations = {
#                 "krm.kcl.dev/composition-resource-name" = "routeTableAssociation1" + _data.zone
#             }
#         }
#         spec.forProvider = {
#             region = _region
#             routeTableIdSelector.matchControllerRef = True
#             subnetIdSelector = {
#                 matchControllerRef = True
#                 matchLabels.zone = _region + _data.zone
#             }
#         }
#     } for _data in _zoneList
# ]

_subnets = [
    {
        apiVersion = "ec2.services.k8s.aws/v1alpha1"
        kind = "Subnet"
        metadata = _metadataSuffix("subnet-{}".format(_data.zone), _data.zone)
        spec = {
            availabilityZone: "{}{}".format(_region, _data.zone)
            cidrBlock: _data.cidrBlock
            vpcRef.from.name = _name
            routeTableRefs = [{from.name = _name}]
            tags = [
            {key = "name", value = _name},
            {key: "zone", value: "{}{}".format(_region, _data.zone)}]
        }
    } for _data in _zoneList
]

# items = _items + _routeTableAssociations + _subnets

items = _items + _subnets
