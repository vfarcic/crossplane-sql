import file

schema composition:
    _provider: str
    _source: str
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
    }

    composition {
        _provider = "aws"
        _source = file.read("kcl/aws.k")
    }

]
