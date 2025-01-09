import file
import .awsstatuses
import .googlestatuses
import .azurestatuses
import .commonstatuses

schema composition:
    _provider: str
    _source: str
    _statusConditionHooks: any
    _serverApiVersion: str
    _serverKind: str
    apiVersion = "apiextensions.crossplane.io/v1"
    kind = "Composition"
    metadata = {
        labels = {
            db = "postgresql"
            provider = _provider
        }
        name = _provider + "-postgresql"
    }
    spec = {
        compositeTypeRef = {
            apiVersion = "devopstoolkit.live/v1alpha1"
            kind = "SQL"
        }
        mode = "Pipeline"
        pipeline = [
            {
                step = "main"
                functionRef.name = "crossplane-contrib-function-kcl"
                input = {
                    apiVersion = "krm.kcl.dev/v1alpha1"
                    kind = "KCLRun"
                    spec = {
                        dependencies = """models = { git = "https://github.com/vfarcic/crossplane-sql", commit = "2d784373b9d988c8820eb78e287cfb7df295e3f4" }"""
                        source = _source
                    }
                }
            }, {
                step = "common"
                functionRef.name = "crossplane-contrib-function-kcl"
                input = {
                    apiVersion = "krm.kcl.dev/v1alpha1"
                    kind = "KCLRun"
                    spec = {
                        dependencies = """models = { git = "https://github.com/vfarcic/crossplane-sql", commit = "2d784373b9d988c8820eb78e287cfb7df295e3f4" }"""
                        source = file.read("kcl/common.k")
                    }
                }
            }, {
                step = "statuses"
                functionRef.name = "crossplane-contrib-function-status-transformer"
                input = {
                    apiVersion = "function-status-transformer.fn.crossplane.io/v1beta1"
                    kind = "StatusTransformation"
                    statusConditionHooks = _statusConditionHooks
                }
            }, {
                step = "automatically-detect-ready-composed-resources"
                functionRef.name = "crossplane-contrib-function-auto-ready"
            }
        ]
        writeConnectionSecretsToNamespace = "crossplane-system"
    }
        
[
    composition {
        _provider = "google"
        _source = file.read("kcl/google.k")
        _statusConditionHooks = commonstatuses.statusConditionHooks(
            "databaseinstance", googlestatuses.googleDataList
        )
        _serverApiVersion = "sql.gcp.upbound.io/v1beta1"
        _serverKind = "DatabaseInstance"
    }

    composition {
        _provider = "aws"
        _source = file.read("kcl/aws.k")
        _statusConditionHooks = commonstatuses.statusConditionHooks(
            "vpc", awsstatuses.awsDataList
        )
        _serverApiVersion = "rds.aws.upbound.io/v1beta1"
        _serverKind = "SubnetGroup"
    }

    composition {
        _provider = "azure"
        _source = file.read("kcl/azure.k")
        _statusConditionHooks = commonstatuses.statusConditionHooks(
            "resourcegroup", azurestatuses.azureDataList
        )
        _serverApiVersion = "dbforpostgresql.azure.upbound.io/v1beta1"
        _serverKind = "Server"
    }

]
