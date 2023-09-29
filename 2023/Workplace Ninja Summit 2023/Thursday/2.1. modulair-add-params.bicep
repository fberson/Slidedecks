// params: string
param hostpoolName string = 'hp-demo-wpns'
param hostpoolType string = 'Pooled'
param loadBalancerType string = 'BreadthFirst'
param preferredAppGroupType string = 'Desktop'

// params: boolean
param enableValidationMode bool = false

// params: integer
param maxSessionLimit int = 10

// resource: AVD hostpool
resource hp 'Microsoft.DesktopVirtualization/hostPools@2023-07-07-preview' = {
  name: hostpoolName
  properties: {
    hostPoolType: hostpoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: preferredAppGroupType
    validationEnvironment: enableValidationMode
    maxSessionLimit: maxSessionLimit
  }
}
