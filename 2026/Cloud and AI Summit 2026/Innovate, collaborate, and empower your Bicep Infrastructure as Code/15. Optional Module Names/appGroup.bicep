param location string
param name string
param hostPoolId string

resource ag 'Microsoft.DesktopVirtualization/applicationGroups@2022-02-10-preview' = {
  name: name
  location: location
  properties: {
    friendlyName: 'AG ${name}'
    applicationGroupType: 'Desktop'
    hostPoolArmPath: hostPoolId
  }
}

output appGroupId string = ag.id
