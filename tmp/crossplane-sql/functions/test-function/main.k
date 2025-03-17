
# import models.io.upbound.aws.ec2.v1beta1 as ec2v1beta1
# import models.io.upbound.aws.ec2.v1beta2 as ec2v1beta2
# import models.io.upbound.aws.rds.v1beta1 as rdsv1beta1
# import models.io.upbound.aws.rds.v1beta2 as rdsv1beta2
# import models.io.upbound.aws.rds.v1beta3 as rdsv1beta3
# import models.io.upbound.aws.v1alpha1 as awsv1alpha1
# import models.io.upbound.aws.v1beta1 as awsv1beta1
# import models.io.upbound.azure.dbforpostgresql.v1beta1 as dbforpostgresqlv1beta1
# import models.io.upbound.azure.dbforpostgresql.v1beta2 as dbforpostgresqlv1beta2
# import models.io.upbound.azure.v1alpha1 as azurev1alpha1
# import models.io.upbound.azure.v1beta1 as azurev1beta1
import models.io.upbound.gcp.sql.v1beta1 as sqlv1beta1
# import models.io.upbound.gcp.sql.v1beta2 as sqlv1beta2
# import models.io.upbound.gcp.v1alpha1 as gcpv1alpha1
# import models.io.upbound.gcp.v1beta1 as gcpv1beta1
# import models.k8s.apimachinery.pkg.apis.meta.v1 as metav1
# import models.live.devopstoolkit.v1alpha1 as devopstoolkitv1alpha1

oxr = option("params").oxr # observed composite resource
_ocds = option("params").ocds # observed composed resources
_dxr = option("params").dxr # desired composite resource
dcds = option("params").dcds # desired composed resources

_region = "us-east1"
if oxr.spec?.parameters?.region:
    _region = oxr.spec.parameters.region

_metadata = lambda name: str -> any {
    { annotations = { "krm.kcl.dev/composition-resource-name" = name }}
}

_items = [
    sqlv1beta1.DatabaseInstance{
        metadata = _metadata("databaseinstance")
        spec = {
            forProvider = {
                region = _region
                databaseVersion = "POSTGRES_" + oxr.spec.parameters.version
                # rootPasswordSecretRef = {
                #     name = oxr.spec.id + "-password"
                #     # namespace = oxr.spec.claimRef.namespace
                #     key = "password"
                # }
                settings = [{
                    if oxr.spec.parameters.size == "small":
                        tier = "db-custom-1-3840"
                    elif oxr.spec.parameters.size == "medium":
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
    }
]
items = _items
