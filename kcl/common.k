oxr = option("params").oxr
ocds = option("params").ocds

schema providerConfig:
    _apiVersion: str
    _suffix: str
    apiVersion = _apiVersion
    kind = "ProviderConfig"
    metadata = {
        name = oxr.spec.id + "-sql"
        annotations = {
            "krm.kcl.dev/ready": "True"
            "krm.kcl.dev/composition-resource-name" = oxr.spec.id + "-provider-config-" + _suffix
        }
    }
    spec = {
        credentials.source = "InjectedIdentity"
    }

_items = [
    providerConfig {
        _apiVersion = "kubernetes.crossplane.io/v1alpha1"
        _suffix = "kubernetes"
    },
    providerConfig {
        _apiVersion = "helm.crossplane.io/v1beta1"
        _suffix = "helm"
}]

items = _items
