import models.io.upbound.aws.ec2.v1beta1 as ec2v1beta1
import models.io.upbound.aws.rds.v1beta1 as rdsv1beta1
import models.io.upbound.aws.rds.v1beta2 as rdsv1beta2

# oxr = {
#     spec = {
#         id = "my-db"
#         claimRef.namespace = "my-namespace"
#         parameters = {
#             size = "small"
#             version = "11.10"
#         }
#     }
# }
# ocds = {}

oxr = option("params").oxr
ocds = option("params").ocds

_region = "us-east-1"
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

_items = [
    ec2v1beta1.InternetGateway {
        metadata = _metadata("gateway")
        spec.forProvider = {
            region = _region
            vpcIdSelector.matchControllerRef = True
        }
    },
    ec2v1beta1.MainRouteTableAssociation {
        metadata = _metadata("mainRouteTableAssociation")
        spec.forProvider = {
            region = _region
            routeTableIdSelector.matchControllerRef = True
            vpcIdSelector.matchControllerRef = True
        }
    },
    ec2v1beta1.RouteTable {
        metadata = _metadata("routeTable")
        spec.forProvider = {
            region = _region
            vpcIdSelector.matchControllerRef = True
        }
    },
    ec2v1beta1.Route {
        metadata = _metadata("route")
        spec.forProvider = {
            region = _region
            routeTableIdSelector.matchControllerRef = True
            destinationCidrBlock = "0.0.0.0/0"
            gatewayIdSelector.matchControllerRef = True
        }
    },
    ec2v1beta1.SecurityGroupRule {
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
    },
    ec2v1beta1.SecurityGroup {
        metadata = _metadata("securityGroup")
        spec.forProvider = {
            region = _region
            description = "I am too lazy to write descriptions"
            vpcIdSelector.matchControllerRef = True
        }
    },
    ec2v1beta1.VPC {
        metadata = _metadata("vpc")
        spec.forProvider = {
            region = _region
            cidrBlock = "11.0.0.0/16"
            enableDnsSupport = True
            enableDnsHostnames = True
        }
    },
    rdsv1beta1.SubnetGroup {
        metadata = _metadata("subnetgroup")    
        spec.forProvider = {
            region = _region
            description = "I'm too lazy to write a good description"
            subnetIdSelector.matchControllerRef = True
        }
    },
    rdsv1beta2.Instance {
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
                name = oxr.spec.id + "-password"
                namespace = oxr.spec.claimRef.namespace
                key = "password"
            }
            identifier = oxr.spec.id
            if oxr.spec.parameters.size == "small":
                instanceClass = "db.m5.large"
            elif oxr.spec.parameters.size == "medium":
                instanceClass = "db.m5.2xlarge"
            else:
                instanceClass = "db.m5.8xlarge"
            engineVersion = oxr.spec.parameters.version
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
                    apiVersion = "rds.aws.upbound.io/v1beta1"
                    kind = "Instance"
                    name = oxr.spec.id
                    namespace = "crossplane-system"
                    fieldPath = "spec.forProvider.username"
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
                    apiVersion = "rds.aws.upbound.io/v1beta1"
                    kind = "Instance"
                    name = oxr.spec.id
                    namespace = "crossplane-system"
                    fieldPath = "status.atProvider.address"
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
        if "rdsinstance" in ocds:
            status.address = ocds["rdsinstance"].Resource.status.atProvider.address
    }
]

_zoneList = [
    { zone = "a", cidrBlock = "11.0.0.0/24" },
    { zone = "b", cidrBlock = "11.0.1.0/24"  },
    { zone = "c", cidrBlock = "11.0.2.0/24"  }
]

_items += [{
    apiVersion = "ec2.aws.upbound.io/v1beta1"
    kind = "RouteTableAssociation"
    metadata = {
        name = oxr.spec.id + "-1" + _data.zone
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
} for _data in _zoneList]

_items += [{
    apiVersion = "ec2.aws.upbound.io/v1beta1"
    kind = "Subnet"
    metadata = {
        name = oxr.spec.id + "-" + _data.zone
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
} for _data in _zoneList]

items = _items
