param hostpoolName string
param hostpoolFriendlyName string
param appgroupName string
param appgroupDesktopFriendlyName string
param appgroupRemoteAppFriendlyName string
param workspaceName string
param workspaceNameFriendlyName string
param preferredAppGroupType string = 'Desktop'
param AVDbackplanelocation string = 'eastus'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'BreadthFirst'
param enableValiatioMode bool
param createRemoteAppHostpool bool

resource hostpool 'Microsoft.DesktopVirtualization/hostPools@2019-12-10-preview' = {
  name: hostpoolName
  location: AVDbackplanelocation
  properties: {
    friendlyName: hostpoolFriendlyName
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: preferredAppGroupType
    validationEnvironment: enableValiatioMode
  }
}

resource appgroup 'Microsoft.DesktopVirtualization/applicationGroups@2022-10-14-preview' = {
  name: appgroupName
  location: AVDbackplanelocation
  properties: {
    friendlyName: appgroupDesktopFriendlyName
    applicationGroupType: 'Desktop'
    hostPoolArmPath: hostpool.id
  }
}

resource hostpoolName_REMOTEAPP 'Microsoft.DesktopVirtualization/hostPools@2022-10-14-preview' = if (createRemoteAppHostpool) {
  name: '${hostpoolName}-REMOTEAPP'
  location: AVDbackplanelocation
  properties: {
    friendlyName: hostpoolFriendlyName
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: 'RailApplications'
    validationEnvironment: enableValiatioMode
  }
}

resource appgroupName_REMOTEAPP 'Microsoft.DesktopVirtualization/applicationGroups@2022-10-14-preview' = if (createRemoteAppHostpool) {
  name: '${appgroupName}-REMOTEAPP'
  location: AVDbackplanelocation
  properties: {
    friendlyName: appgroupRemoteAppFriendlyName
    applicationGroupType: 'RemoteApp'
    hostPoolArmPath: hostpoolName_REMOTEAPP.id
  }
}

resource workspace 'Microsoft.DesktopVirtualization/workspaces@2022-10-14-preview' = {
  name: workspaceName
  location: AVDbackplanelocation
  properties: {
    friendlyName: workspaceNameFriendlyName
    applicationGroupReferences: [
      appgroup.id
      (createRemoteAppHostpool ? appgroupName_REMOTEAPP.id : '')
    ]
  }
}