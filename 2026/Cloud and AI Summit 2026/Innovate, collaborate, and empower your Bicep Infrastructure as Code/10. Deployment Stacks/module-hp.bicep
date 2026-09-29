param AVDbackplanelocation string = 'westeurope'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'DepthFirst'
param hostpoolName string = 'BICEP-P-AVD-HP'
param preferredAppGroupType string = 'Desktop'
param AVDHostPoolfriendlyname string = 'updated friendlyname'
param enableValiatioMode bool = true

//Create AVD Hostpool
resource hpra 'Microsoft.DesktopVirtualization/hostpools@2024-04-03' = {
  name: hostpoolName
  location: AVDbackplanelocation
  properties: {
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: preferredAppGroupType
    validationEnvironment: enableValiatioMode
    friendlyName: AVDHostPoolfriendlyname
  }
}

output hpid string = hpra.id
