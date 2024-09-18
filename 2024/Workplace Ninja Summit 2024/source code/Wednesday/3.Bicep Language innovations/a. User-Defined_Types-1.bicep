@description('Array of AVD Host Pools')
@minLength(1)
param hostPoolsConfigEurope array = [
  {
    name: 'AVDHostPool1' // Name of the host pool
    location: 'westeurope' //For location use westeurope or northeurope only
    managementType: 'Standard' //For managementType use Standard or automated
    friendlyName: 'AVDHostPool1' //Friendly name of the host pool
    description: 'AVDHostPool1' //Description of the host pool
    hostPoolType: 'Pooled' //For hostPoolType use Pooled or Personal
    maxSessionLimit: 10 //Maximum session limit
    loadBalancerType: 'DepthFirst' //For loadBalancerType use DepthFirst or BreadthFirst
    validationEnvironment: false //Validation environment
    preferredAppGroupType: 'Desktop' //Use Desktop or RailApplications
    startVMOnConnect: true
  }
]

resource demoHostPool 'Microsoft.DesktopVirtualization/hostPools@2024-04-08-preview' = [
  for hostPoolConfigEurope in hostPoolsConfigEurope: {
    name: hostPoolConfigEurope.name
    location: hostPoolConfigEurope.location
    properties: {
      managementType: hostPoolConfigEurope.managementType
      friendlyName: hostPoolConfigEurope.friendlyName
      description: hostPoolConfigEurope.description
      hostPoolType: hostPoolConfigEurope.hostPoolType
      maxSessionLimit: hostPoolConfigEurope.maxSessionLimit
      loadBalancerType: hostPoolConfigEurope.loadBalancerType
      validationEnvironment: hostPoolConfigEurope
      preferredAppGroupType: hostPoolConfigEurope.preferredAppGroupType
      startVMOnConnect: hostPoolConfigEurope.startVMOnConnect
    }
  }
]


