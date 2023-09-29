//Define AVD deployment parameters
param AVDbackplanelocation string = 'westeurope'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'DepthFirst' // 'DepthFirst' 
param hostpoolName string = 'BICEP-P-AVD-HP'
param appgroupName string = 'BICEP-P-AVD-HP-AG'
param workspaceName string = 'BICEP-P-AVD-HP-WS'
param preferredAppGroupType string = 'Desktop'
param AVDHostPoolfriendlyname string = 'updated friendlyname' // updated
param enableValiatioMode bool = true // 'true'
param createRemoteAppHostpool bool = true

//Create AVD RemoteApp Hostpool
resource hpra 'Microsoft.DesktopVirtualization/hostpools@2022-10-14-preview' = if (createRemoteAppHostpool){
  name: '${hostpoolName}-REMOTEAPP'
  location: AVDbackplanelocation
  properties: {
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: preferredAppGroupType
    validationEnvironment: enableValiatioMode
    friendlyName: AVDHostPoolfriendlyname
  }
}


//Create AVD RemoteApp AppGroup
resource agra 'Microsoft.DesktopVirtualization/applicationgroups@2022-10-14-preview' = if (createRemoteAppHostpool){
  name: '${appgroupName}-REMOTEAPP'
  location: AVDbackplanelocation
  properties: {
    applicationGroupType:  'RemoteApp'
    hostPoolArmPath: hpra.id
  }
}

//Create AVD Workspace in case createRemoteAppHostpool = false
resource ws 'Microsoft.DesktopVirtualization/workspaces@2022-10-14-preview' = {
  name: workspaceName
  location: AVDbackplanelocation
  properties: {
    applicationGroupReferences: [
      createRemoteAppHostpool ? agra.id : ''
    ]
  }
}



