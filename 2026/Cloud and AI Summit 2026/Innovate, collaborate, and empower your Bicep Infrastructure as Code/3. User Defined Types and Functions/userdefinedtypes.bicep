// Example: User Defined Types with AVD Resources
param hostPoolName string = 'demoHostPool'

// Define a user type for Host Pool properties
@description('Defines the properties for an AVD Host Pool')
type myHostPoolType = {
  hostPoolType: string
  preferredAppGroupType: string
  customRdpProperty: string  
  loadBalancerType: string
}

param hostPoolProps myHostPoolType = {
  hostPoolType: 'Pooled'
  preferredAppGroupType: 'Desktop'
  customRdpProperty: 'audiocapturemode:i:1'
  loadBalancerType : 'BreadthFirst'
}

//@sealed()
type anObject = {
  property: string
  optionalProperty: string?
}
 
param aParameter anObject = {
  property: 'value'
  otionalProperty: 'value'
}

resource avdHostPool 'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview' = {
  name: hostPoolName
  location: 'eastus'
  properties: hostPoolProps  
}

// Define a user type for Application Group properties
@description('Defines the properties for an AVD Application Group')
type myAppGroupType = {
  appGroupType: string
  description: string
  friendlyName: string
  outputText: string
}

// Example parameter using the user defined type for Application Group
param appGroupProps myAppGroupType = {
  appGroupType: 'Desktop'
  description: 'Demo Desktop Application Group'
  friendlyName: 'DemoAppGroup'
  outputText: 'myAppGroupType used successfully'
}

// Create an Application Group resource using the user defined type
resource avdAppGroup 'Microsoft.DesktopVirtualization/applicationGroups@2022-02-10-preview' = {
  name: '${hostPoolName}-appgroup'
  location: 'eastus'
  properties: {
    applicationGroupType: appGroupProps.appGroupType
    hostPoolArmPath: avdHostPool.id
    description: appGroupProps.description
    friendlyName: appGroupProps.friendlyName
  }
}

output appGroupOutput string = appGroupProps.outputText
output aParameter string = aParameter.property


