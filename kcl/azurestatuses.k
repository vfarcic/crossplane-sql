azureDataList = [{
    matcher.message = "(.*)The specified location '(?P<Region>.*)' is invalid(.*)"
    setCondition = {
        message = "Selected region {{ .Region }} is not available. Double check the `spec.region` value."
    }
}, {
    matcher.message = "(.*)The provided location '(?P<Region>.*)' is not available for resource group(.*)"
    setCondition = {
        message = "Selected region {{ .Region }} is not available. Double check the `spec.region` value."
    }
}]
