param hostpoolconfigs hostPoolConfigEurope

@export()
@description('Configuration of AVD Host Pools in Europe')
@metadata({
 name: 'Name of the host pool'
  location: 'For location use westeurope or northeurope'
  managementType: 'For managementType use Standard or automated'
  friendlyName: 'Friendly name of the host pool'
  descriptionHP: 'Description of the host pool'
  hostPoolType: 'For hostPoolType use Pooled or Personal'
  maxSessionLimit: 'Maximum session limit'
  loadBalancerType: 'For loadBalancerType use DepthFirst or BreadthFirst'
  validationEnvironment: 'Validation environment'
  preferredAppGroupType: 'Use Desktop or RailApplications'
  startVMOnConnect: 'Start VM on connect'
}
)
type hostPoolConfigEurope = [
  {
    name: string
    location: 'westeurope' | 'northeurope'
    managementType: 'Standard' | 'automated'
    friendlyName: string
    descriptionHP: string
    hostPoolType: 'Pooled' | 'Personal'
    maxSessionLimit: int
    loadBalancerType: 'DepthFirst' | 'BreadthFirst'
    validationEnvironment: false
    preferredAppGroupType: 'Desktop' | 'RailApplications'
    startVMOnConnect: true
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

