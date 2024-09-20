awsDataList = [{
    matcher.message = "(.*)lookup sts.(?P<Region>.*).amazonaws.com on (.*): no such host(.*)"
    setCondition = {
        type = "RegionAvailable"
        message = "selected region {{ .Region }} is not available. Double check the `spec.parameters.region` value."
    }
}]
