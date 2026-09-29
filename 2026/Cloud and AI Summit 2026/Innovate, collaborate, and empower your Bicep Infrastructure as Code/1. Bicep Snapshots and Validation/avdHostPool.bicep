param AVDbackplanelocation string = 'westeurope'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'DepthFirst'
param hostpoolName string = 'BICEP-P-AVD-HP'
param appgroupName string = 'BICEP-P-AVD-HP-AG'
param workspaceName string = 'BICEP-P-AVD-HP-WS'
param preferredAppGroupType string = 'Desktop'
param AVDHostPoolfriendlyname string = 'friendlyname'
param enableValiatioMode bool = true
param createRemoteAppHostpool bool = true
param maxSessionLimit int = 1

//Create AVD RemoteApp Hostpool
resource hpra 'Microsoft.DesktopVirtualization/hostpools@2026-01-01-preview' =
  if (createRemoteAppHostpool) {
    name: '${hostpoolName}-REMOTEAPP'
    location: AVDbackplanelocation
    properties: {
      hostPoolType: hostPoolType
      loadBalancerType: loadBalancerType
      preferredAppGroupType: preferredAppGroupType
      validationEnvironment: enableValiatioMode
      friendlyName: AVDHostPoolfriendlyname
      maxSessionLimit: maxSessionLimit
    }
  }

  resource ag 'Microsoft.DesktopVirtualization/applicationGroups@2026-01-01-preview' = {
    name: appgroupName
    location: AVDbackplanelocation
    properties: {
      hostPoolArmPath: hpra.id
      applicationGroupType: preferredAppGroupType
    }
  }


//Create AVD Workspace in case createRemoteAppHostpool = false
resource ws 'Microsoft.DesktopVirtualization/workspaces@2026-01-01-preview' = {
  name: workspaceName
  location: AVDbackplanelocation
  properties: {
    applicationGroupReferences: [
      ag.id
    ]
  }
}
