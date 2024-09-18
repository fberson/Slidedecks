param location string
param expirationtime string = utcNow('u')
param preferredAppGroupType string
param applicationGroupType string

@export()
var prefix = 'my-prefix'

resource hp 'Microsoft.DesktopVirtualization/hostPools@2023-11-01-preview' = {
  name: '${prefix}-hostpool'
  location: location
  properties: {
    hostPoolType: 'Pooled'
    preferredAppGroupType: preferredAppGroupType
    loadBalancerType: 'BreadthFirst'
    registrationInfo: {
      registrationTokenOperation: 'Update'
      expirationTime: dateTimeAdd(expirationtime, 'PT2H')
    }
  }
}

resource ag 'Microsoft.DesktopVirtualization/applicationGroups@2023-11-01-preview' = {
  name: '${prefix}-applicationgroup'
  location: location
  properties: {
    hostPoolArmPath: hp.id
    applicationGroupType: applicationGroupType
  }
}

resource ws 'Microsoft.DesktopVirtualization/workspaces@2023-11-01-preview' = {
  name: '${prefix}-workspace'
  location: location
  properties: {
    applicationGroupReferences: [
      ag.id
    ]
  }
}

output hostPoolRegistrationtoken string = hp.properties.registrationInfo.token
