oxr = option("params").oxr
ocds = option("params").ocds

_name = oxr.metadata.name
_namespace = oxr.metadata.namespace
_region = "us-east-1"
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

_items = [
    {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "InternetGateway"
        metadata = _metadata("gateway")
        spec.forProvider = {
            region = _region
            vpcIdSelector.matchControllerRef = True
        }
    },
    {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "MainRouteTableAssociation"
        metadata = _metadata("mainRouteTableAssociation")
        spec.forProvider = {
            region = _region
            routeTableIdSelector.matchControllerRef = True
            vpcIdSelector.matchControllerRef = True
        }
    }, {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "RouteTable"
        metadata = _metadata("routeTable")
        spec.forProvider = {
            region = _region
            vpcIdSelector.matchControllerRef = True
        }
    }, {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "Route"
        metadata = _metadata("route")
        spec.forProvider = {
            region = _region
            routeTableIdSelector.matchControllerRef = True
            destinationCidrBlock = "0.0.0.0/0"
            gatewayIdSelector.matchControllerRef = True
        }
    }, {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "SecurityGroupRule"
        metadata = _metadata("securityGroupRule")
        spec.forProvider = {
            region = _region
            description = "I am too lazy to write descriptions"
            type = "ingress"
            fromPort = 5432
            toPort = 5432
            protocol = "tcp"
            cidrBlocks = ["0.0.0.0/0"]
            securityGroupIdSelector.matchControllerRef = True
        }
    }, {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "SecurityGroup"
        metadata = _metadata("securityGroup")
        spec.forProvider = {
            region = _region
            description = "I am too lazy to write descriptions"
            vpcIdSelector.matchControllerRef = True
        }
    }, {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "VPC"
        metadata = _metadata("vpc")
        spec.forProvider = {
            region = _region
            cidrBlock = "11.0.0.0/16"
            enableDnsSupport = True
            enableDnsHostnames = True
        }
    }, {
        apiVersion = "rds.aws.m.upbound.io/v1beta1"
        kind = "SubnetGroup"
        metadata = _metadata("subnetgroup")
        spec.forProvider = {
            region = _region
            description = "I'm too lazy to write a good description"
            subnetIdSelector.matchControllerRef = True
        }
    }, {
        apiVersion = "rds.aws.m.upbound.io/v1beta1"
        kind = "Instance"
        metadata = _metadata("rdsinstance")
        spec.forProvider = {
            region = _region
            dbSubnetGroupNameSelector.matchControllerRef = True
            vpcSecurityGroupIdSelector.matchControllerRef = True
            username = "masteruser"
            engine = "postgres"
            skipFinalSnapshot = True
            publiclyAccessible = True
            allocatedStorage = 200
            passwordSecretRef = {
                name = _name + "-password"
                key = "password"
            }
            storageEncrypted = True
            identifier = _name
            if oxr.spec.size == "small":
                instanceClass = "db.m5.large"
            elif oxr.spec.size == "medium":
                instanceClass = "db.m5.2xlarge"
            else:
                instanceClass = "db.m5.8xlarge"
            engineVersion = oxr.spec.version
            # TODO: Remove when `postgresql.sql.crossplane.io` is adapted to v2
            if oxr.spec?.databases:
                dbName = oxr.spec.databases[0]
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
                    apiVersion = "rds.aws.m.upbound.io/v1beta1"
                    kind = "Instance"
                    name = _name
                    namespace = _namespace
                    fieldPath = "spec.forProvider.username"
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
                    apiVersion = "rds.aws.m.upbound.io/v1beta1"
                    kind = "Instance"
                    name = _name
                    namespace = _namespace
                    fieldPath = "status.atProvider.address"
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
        if "rdsinstance" in ocds:
            status.address = ocds["rdsinstance"].Resource.status.atProvider.address
    }
]

_zoneList = [
    { zone = "a", cidrBlock = "11.0.0.0/24" },
    { zone = "b", cidrBlock = "11.0.1.0/24"  },
    { zone = "c", cidrBlock = "11.0.2.0/24"  }
]

_routeTableAssociations = [
    {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "RouteTableAssociation"
        metadata = {
            name = _name + "-1" + _data.zone
            annotations = {
                "krm.kcl.dev/composition-resource-name" = "routeTableAssociation1" + _data.zone
            }
        }
        spec.forProvider = {
            region = _region
            routeTableIdSelector.matchControllerRef = True
            subnetIdSelector = {
                matchControllerRef = True
                matchLabels.zone = _region + _data.zone
            }
        }
    } for _data in _zoneList
]

_subnets = [
    {
        apiVersion = "ec2.aws.m.upbound.io/v1beta1"
        kind = "Subnet"
        metadata = {
            name = _name + "-" + _data.zone
            annotations = {
                "krm.kcl.dev/composition-resource-name" = "subnet-" + _data.zone
            }
            labels = {
                zone = _region + _data.zone
            }
        }
        spec.forProvider = {
            region = _region
            availabilityZone = _region + _data.zone
            cidrBlock = _data.cidrBlock
            vpcIdSelector.matchControllerRef = True
        }
    } for _data in _zoneList
]

items = _items + _routeTableAssociations + _subnets
