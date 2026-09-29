//Define AVD deployment parameters
@description('Name of the Azure Virtual Desktop host pool')
param hostpoolName string

@description('Friendly name of the Azure Virtual Desktop host pool')
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

//Create AVD Hostpool
resource hp 'Microsoft.DesktopVirtualization/hostpools@2026-04-01-preview' = {
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

//Create AVD Desktop AppGroup
resource agd 'Microsoft.DesktopVirtualization/applicationgroups@2026-04-01-preview' = {
  name: appgroupName
  location: AVDbackplanelocation
  properties: {
    friendlyName: appgroupDesktopFriendlyName
    applicationGroupType:  'Desktop'
    hostPoolArmPath: hp.id
  }
}

//Create AVD RemoteApp Hostpool
resource hpra 'Microsoft.DesktopVirtualization/hostpools@2026-04-01-preview' = if (createRemoteAppHostpool){
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


//Create AVD RemoteApp AppGroup
resource agra 'Microsoft.DesktopVirtualization/applicationgroups@2026-04-01-preview' = if (createRemoteAppHostpool){
  name: '${appgroupName}-REMOTEAPP'
  location: AVDbackplanelocation
  properties: {
    friendlyName: appgroupRemoteAppFriendlyName
    applicationGroupType:  'RemoteApp'
    hostPoolArmPath: hpra.id
  }
}

//Create AVD Workspace in case createRemoteAppHostpool = false
resource ws 'Microsoft.DesktopVirtualization/workspaces@2026-04-01-preview' = {
  name: workspaceName
  location: AVDbackplanelocation
  properties: {
    friendlyName: workspaceNameFriendlyName
    applicationGroupReferences: [
      agd.id
      createRemoteAppHostpool ? agra.id : ''
    ]
  }
}

// ===============================
// OUTPUTS
// ===============================

@description('The name of the host pool')
output hostpoolName string = hp.name

@description('The resource ID of the host pool')
output hostpoolResourceId string = hp.id

@description('The resource ID of the desktop application group')
output desktopAppGroupId string = agd.id

@description('The resource ID of the remote app application group (if created)')
output remoteAppGroupId string = createRemoteAppHostpool ? agra.id : ''

@description('The name of the workspace')
output workspaceName string = ws.name

@description('The resource ID of the workspace')
output workspaceId string = ws.id

@description('Host pool registration token (for VM domain join)')
output registrationToken string = hp.properties.registrationInfo.token



