_statusConditionHooks = [{
    matchers = [{
        resources = [{
            name = "vpc"
        }]
        conditions = [{
            type = "Synced"
            status = "False"
            reason = "ReconcileError"
            message = "\.*cannot get referenced ProviderConfig\.*"
        }]
    }]
    setConditions = [{
        target = "CompositeAndClaim"
        condition = {
            type = "ProviderConfigReady"
            status = "False"
            reason = "FailedToConnect"
            message = "providerConfig is missing. Contact service owner."
        }
    }]
}, {
    matchers = [{
        resources = [{
            name = "vpc"
        }]
        conditions = [{
            type = "Synced"
            status = "False"
            reason = "ReconcileError"
            message = "(.*)lookup sts.(?P<Region>.*).amazonaws.com on (.*): no such host(.*)"
        }]
    }]
    setConditions = [{
        target = "CompositeAndClaim"
        condition = {
            type = "RegionAvailable"
            status = "False"
            reason = "FailedToConnect"
            message = "Selected region {{ .Region }} is not available. Double check the `spec.parameters.region` value."
        }
    }]
}]
