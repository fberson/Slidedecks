module hp 'hostpoolModule.bicep' = {
  name: 'deployHostPool'
  params: {
    location: resourceGroup().location
    preferredAppGroupType: 'Desktop'
    maxSessionLimit1: 11
    maxSessionLimit2: 3
    maxSessionLimit3: 6
  }
} 
