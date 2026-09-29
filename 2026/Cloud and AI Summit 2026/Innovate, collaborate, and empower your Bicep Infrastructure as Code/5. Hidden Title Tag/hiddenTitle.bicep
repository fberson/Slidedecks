param location string = resourceGroup().location
param hostPoolName string = 'avd-hp-prd-A-001'

resource hostpool 'Microsoft.DesktopVirtualization/hostPools@2026-01-01-preview' = {
  name: hostPoolName
  location: location
  tags: {
    // Hidden alias in the Azure portal
    'hidden-title': 'Production AVD Host Pool'
    // Normal tags
    Environment: 'Production'
    Owner: 'VDI Team'
  }
  properties: {
    friendlyName: 'AVD Prod Pool'
    description: 'Main production host pool'
    hostPoolType: 'Pooled'
    personalDesktopAssignmentType: 'Automatic'
    preferredAppGroupType: 'Desktop'
    loadBalancerType: 'BreadthFirst'
  }
}
