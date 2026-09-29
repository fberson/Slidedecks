// Without azExtensionConfig, deployment can fail if the required
// resource provider has not previously been registered:
//
// ERROR: Deployment failed.
// Code: MissingSubscriptionRegistration
// Message: The subscription is not registered to use namespace
// 'Microsoft.HybridCompute'.

extension az with {
  providers: [
    'Microsoft.DesktopVirtualization'
    'Microsoft.HybridCompute'
  ]
}

param location string = resourceGroup().location
param hostPoolName string = 'hp-avd-hybrid'
param sessionHostName string = 'AVD-HYBRID-01'
param tokenExpirationTime string = dateTimeAdd(utcNow(), 'PT2H')

resource hostPool 'Microsoft.DesktopVirtualization/hostPools@2025-10-10' = {
  name: hostPoolName
  location: location
  properties: {
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    preferredAppGroupType: 'Desktop'
  }
}

resource arcSessionHost 'Microsoft.HybridCompute/machines@2026-06-16-preview' existing = {
  name: sessionHostName
}

resource cloudDeviceExtension 'Microsoft.HybridCompute/machines/extensions@2025-06-01' = {
  parent: arcSessionHost
  name: 'Microsoft.AzureVirtualDesktop.CloudDeviceExtension'
  location: location
  properties: {
    publisher: 'Microsoft.AzureVirtualDesktop'
    type: 'CloudDeviceExtension'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      isCloudDevice: false
    }
    protectedSettings: {
      registrationToken: hostPoolRegistration.properties.token
    }
  }
}

resource hostPoolRegistration 'Microsoft.DesktopVirtualization/hostPools/registrationInfo@2025-10-10' = {
  parent: hostPool
  name: 'default'
  properties: {
    expirationTime: tokenExpirationTime
  }
}

output demoSummary object = {
  allowedProviders: [
    'Microsoft.DesktopVirtualization'
    'Microsoft.HybridCompute'
  ]
  hostPoolId: hostPool.id
  arcMachineId: arcSessionHost.id
  extensionResourceId: cloudDeviceExtension.id
}
