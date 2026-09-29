param location string
param name string

resource hp 'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview' = {
  name: name
  location: location
  properties: {
    friendlyName: 'HP ${name}'
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    preferredAppGroupType: 'Desktop'
    startVMOnConnect: false
    validationEnvironment: false
  }
}

output hostPoolId string = hp.id
