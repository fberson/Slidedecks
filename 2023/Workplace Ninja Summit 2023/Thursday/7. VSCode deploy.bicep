param location string = 'westeurope' //westeurope
param workspaceName string = 'bicep-avd-workspace'
param hostpoolName string = 'bicep-avd-hostpool'
param appgroupName string = 'bicep-avd-appgroup'
param preferredAppGroupType string = 'Desktop'
param hostPoolType string = 'pooled'
param loadbalancertype string = 'BreadthFirst'
param appgroupType string = 'Desktop'

resource hostpool 'Microsoft.DesktopVirtualization/hostPools@2022-10-14-preview' = {
  name: hostpoolName
  location: location
  properties: {
    friendlyName: 'My Bicep generated Host pool'
    hostPoolType: hostPoolType
    loadBalancerType: loadbalancertype
    preferredAppGroupType: preferredAppGroupType
  }
}

resource appgroup 'Microsoft.DesktopVirtualization/applicationGroups@2022-10-14-preview' = {
  name: appgroupName
  location: location
  properties: {
    friendlyName: 'My Bicep generated application Group'
    applicationGroupType: appgroupType
    hostPoolArmPath: hostpool.id
  }
}

resource workspace 'Microsoft.DesktopVirtualization/workspaces@2022-10-14-preview' = {
  name: workspaceName
  location: location
  properties: {
    friendlyName: 'My Bicep generated Workspace'
    applicationGroupReferences: [appgroup.id]
  }
}

output workspaceid string = workspace.id
