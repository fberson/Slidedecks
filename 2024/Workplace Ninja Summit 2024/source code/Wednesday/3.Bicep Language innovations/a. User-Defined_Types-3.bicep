import * as myImports from 'a. User-Defined_Types-2.bicep'

param hostpoolconfigs myImports.hostPoolConfigEurope = [
  {
    name: 'AVDHostPool1'
    location: 'westeurope'
    descriptionHP: 'My first host pool'
    friendlyName: 'My first host pool'
    hostPoolType: 'Pooled'
    loadBalancerType: 'DepthFirst'
    managementType: 'automated'
    maxSessionLimit: 666
    preferredAppGroupType: 'RailApplications'
    startVMOnConnect: true
    validationEnvironment: false
  }
]

resource demoHostPool 'Microsoft.DesktopVirtualization/hostPools@2024-04-08-preview' = [
  for hostpoolconfig in hostpoolconfigs: {
    name: hostpoolconfig.name
    location: hostpoolconfig.location
    properties: {
      managementType: hostpoolconfig.managementType
      friendlyName: hostpoolconfig.friendlyName
      description: hostpoolconfig.descriptionHP
      hostPoolType: hostpoolconfig.hostPoolType
      maxSessionLimit: hostpoolconfig.maxSessionLimit
      loadBalancerType: hostpoolconfig.loadBalancerType
      validationEnvironment: hostpoolconfig.validationEnvironment
      preferredAppGroupType: hostpoolconfig.preferredAppGroupType
      startVMOnConnect: hostpoolconfig.startVMOnConnect
    }
  }
]
