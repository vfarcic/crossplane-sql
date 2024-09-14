oxr = option("params").oxr
ocds = option("params").ocds

_metadata = lambda resourceName: str -> any {
    {
        name = oxr.spec.id
        annotations = {
            # "crossplane.io/external-name" = oxr.spec.id
            "krm.kcl.dev/composition-resource-name" = resourceName
        }
    }
}

_items = [{
    apiVersion = "ec2.aws.upbound.io/v1beta1"
    kind = "InternetGateway"
    metadata = _metadata("gateway")
    spec.forProvider = {
        region = "us-east-1"
        vpcIdSelector.matchControllerRef = True
    }
}, {
    apiVersion = "ec2.aws.upbound.io/v1beta1"
    kind = "MainRouteTableAssociation"
    metadata = _metadata("mainRouteTableAssociation")
    spec.forProvider = {
        region = "us-east-1"
        routeTableIdSelector.matchControllerRef = True
        vpcIdSelector.matchControllerRef = True
    }
#     **oxr
#     if oxr.spec.id + "-sql" in ocds:
#         status.address = ocds[oxr.spec.id + "-sql"].Resource.status.atProvider.publicIpAddress
}]

items = _items
