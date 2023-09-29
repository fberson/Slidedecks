targetScope = 'resourceGroup'

param location string = resourceGroup().location
param hostpoolName string = 'hp-demo-wpns'
@allowed(['BYODesktop','Pooled','Personal'])
param hostpoolType string = 'Pooled'
@allowed(['BreadthFirst','DepthFirst','Persistant'])
param loadBalancerType string = 'BreadthFirst'
@allowed(['Desktop','None','RailApplications'])
param preferredAppGroupType string = 'Desktop'
param enableValidationMode bool = false
@minValue(1)
@maxValue(100)
param maxSessionLimit int = 10

resource hp 'Microsoft.DesktopVirtualization/hostPools@2023-07-07-preview' = {
  name: hostpoolName
  location: location
  properties: {
    hostPoolType: hostpoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: preferredAppGroupType
    validationEnvironment: enableValidationMode
    maxSessionLimit: maxSessionLimit
  }
}
