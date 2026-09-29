//default types
param hostPoolName string = 'exampleHostPool'
param location string = 'westeurope'
param validationEnvironment bool = false

// Example: Using resource derived types for AVD Host Pool
param hostPoolType resourceInput<'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview'>.properties.hostPoolType
param preferredAppGroupType resourceInput<'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview'>.properties.preferredAppGroupType

resource avdHostPool 'Microsoft.DesktopVirtualization/hostPools@2026-01-01-preview' = {
  name: hostPoolName
  location: location
  properties: {
    hostPoolType: hostPoolType
    preferredAppGroupType: preferredAppGroupType
    loadBalancerType: 'BreadthFirst'
    validationEnvironment: validationEnvironment
  }
}
