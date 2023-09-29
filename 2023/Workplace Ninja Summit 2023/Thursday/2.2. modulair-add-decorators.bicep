param hostpoolName string = 'hp-demo-wpns'

// decorator: select (allowed values) list
@allowed(['BYODesktop','Pooled','Personal'])
param hostpoolType string = 'Pooled'
@allowed(['BreadthFirst','DepthFirst','Persistant'])
param loadBalancerType string = 'BreadthFirst'
@allowed(['Desktop','None','RailApplications'])
param preferredAppGroupType string = 'Desktop'

param enableValidationMode bool = false

// decorator: value (min-max) range
@minValue(1)
@maxValue(100)
param maxSessionLimit int = 10

// decorator: secure string (and linter rules)
@secure()
param secretPassword string = 'supersecret'

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
