import file
import .awsstatuses
import .googlestatuses
import .azurestatuses
import .commonstatuses

schema composition:
    _provider: str
    _source: str
    _statusConditionHooks: any
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
            apiVersion = "devopstoolkitseries.com/v1alpha1"
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
                    spec.source = _source
                }
            }, {
                step = "common"
                functionRef.name = "crossplane-contrib-function-kcl"
                input = {
                    apiVersion = "krm.kcl.dev/v1alpha1"
                    kind = "KCLRun"
                    spec.source = file.read("kcl/common.k")
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
    }

    composition {
        _provider = "aws"
        _source = file.read("kcl/aws.k")
        _statusConditionHooks = commonstatuses.statusConditionHooks(
            "vpc", awsstatuses.awsDataList
        )
    }

    composition {
        _provider = "azure"
        _source = file.read("kcl/azure.k")
        _statusConditionHooks = commonstatuses.statusConditionHooks(
            "resourcegroup", azurestatuses.azureDataList
        )
    }

]
