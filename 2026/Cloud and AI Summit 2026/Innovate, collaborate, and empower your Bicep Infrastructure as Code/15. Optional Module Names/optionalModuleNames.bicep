param location string = resourceGroup().location
param hostPoolName string = 'hp-demo'
param appGroupName string = 'ag-demo'

module appGroup './appGroup.bicep' = {
  name: 'avd-appgroup' // explicit, human-friendly
  params: {
    location: location
    name: appGroupName
    hostPoolId: hostPool.outputs.hostPoolId
  }
}

module hostPool './hostPool.bicep' = {
  // name:  <-- intentionally omitted
  params: {
    location: location
    name: hostPoolName
  }
}

output hostPoolId string = hostPool.outputs.hostPoolId
output appGroupId string = appGroup.outputs.appGroupId
