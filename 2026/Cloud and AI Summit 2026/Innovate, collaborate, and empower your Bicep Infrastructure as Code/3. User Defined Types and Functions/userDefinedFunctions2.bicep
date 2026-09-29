import * as myAvdFunctions from './userDefinedFunctions.bicep'

param hostPoolName string = 'demoHostPool'

resource avdHostPool 'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview' = {
  name: hostPoolName
  location: 'eastus'
  properties: {
    hostPoolType: 'Pooled'
    preferredAppGroupType: 'Desktop'
    loadBalancerType: 'BreadthFirst'
    customRdpProperty: myAvdFunctions.buildRdpProperty(true, true, false, true, 1920, 1080)
  }
}
