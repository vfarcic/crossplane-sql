commonDataList = [{
    matcher.message = "(.*)cannot get referenced ProviderConfig(.*)"
    setCondition = {
        message = "ProviderConfig is missing. Contact service owner."
    }
}]

statusConditionHooks = lambda resource: str, dataList: any -> any {
    _dataList = commonDataList + dataList
    [{
        matchers = [{
            resources = [{
                name = resource
            }]
            conditions = [{
                type = "Synced"
            }]
        }]
        setConditions = [{
            target = "CompositeAndClaim"
            force = True
            condition = {
                type = "Developer"
                status = "True"
                message = "So far so good"
            }
        }]
    }] + [{
        matchers = [{
            resources = [{
                name = resource
            }]
            conditions = [{
                type = "Synced"
                status = "False"
                reason = "ReconcileError"
                message = _data.matcher.message
            }]
        }]
        setConditions = [{
            target = "CompositeAndClaim"
            force = True
            condition = {
                type = "Developer"
                status = "False"
                reason = "FailedToConnect"
                message = _data.setCondition.message
            }
        }]
    } for _data in _dataList]
}