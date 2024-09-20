azureDataList = [{
    matcher.message = "(.*)The specified location '(?P<Region>.*)' is invalid(.*)"
    setCondition = {
        type = "RegionAvailable"
        message = "selected region {{ .Region }} is not available. Double check the `spec.parameters.region` value."
    }
}, {
    matcher.message = "(.*)The provided location '(?P<Region>.*)' is not available for resource group(.*)"
    setCondition = {
        type = "RegionAvailable"
        message = "selected region {{ .Region }} is not available. Double check the `spec.parameters.region` value."
    }
}]
