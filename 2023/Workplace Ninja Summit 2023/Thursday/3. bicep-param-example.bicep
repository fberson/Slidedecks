//Define AVD deployment parameters
param hostpoolName string
param hostpoolFriendlyName string = 'A demo host pool' 
param preferredAppGroupType string = 'Desktop'
param AVDbackplanelocation string = 'eastus' 
param hostPoolType string = 'pooled'
@allowed(['BreadthFirst', 'DepthFirst'])
param loadBalancerType string = 'BreadthFirst'
param enableValiationMode bool = false
@minValue(1)
@maxValue(100)
param maxSessionLimit int = 10
@secure()
param secretDescription string
param secretValue string

//Create the AVD hostpool
resource hp 'Microsoft.DesktopVirtualization/hostPools@2022-10-14-preview' = {
  name: hostpoolName
  location: AVDbackplanelocation
  properties: {
    friendlyName: hostpoolFriendlyName
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    preferredAppGroupType: preferredAppGroupType
    validationEnvironment: enableValiationMode
    maxSessionLimit: maxSessionLimit
    description: secretDescription
  }
}

//Output the hostpool name
output hpname string = hp.id
