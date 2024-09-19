_statusConditionHooks = [{
    matchers = [{
        resources = [{
            name = "resourcegroup"
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
}]
