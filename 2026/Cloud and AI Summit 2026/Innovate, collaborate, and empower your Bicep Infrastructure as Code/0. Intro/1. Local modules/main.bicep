targetScope = 'subscription'
param location string
param vnetname string
param subNetName string
param localAdminName string
param expirationtime string = utcNow('u')

@secure()
param localAdminPassword string
param avdbackplanes array = [
  {
    postfix: 'FD'
    preferredAppGroupType: 'Desktop'
    applicationGroupType: 'Desktop'
  }
  {
    postfix: 'RA'
    preferredAppGroupType: 'RailApplications'
    applicationGroupType: 'RemoteApp'
  }
]

@onlyIfNotExists()
resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'BICEP-LOOP-DEMO'
  location: location
}

//Local Bicep module
module vnet './module-vnet.bicep' = {
  name: 'vnet'
  scope: rg
  params: {
    vnetLocation: location
    vnetName: vnetname
    subNetName: subNetName
  }
}

module vm 'module-vm.bicep' = {
  name: 'VM'
  scope: rg
  params: {
    localAdminName: localAdminName
    localAdminPassword: localAdminPassword
    vnetName: vnetname
    subNetName: subNetName
    defaultLocation: location
  }
}

module backplanedeploy 'module-avd.bicep' = [
  for avdbackplane in avdbackplanes: {
    name: '${avdbackplane.applicationGroupType}-deploy'
    scope: rg
    params: {
      location: rg.location
      applicationGroupType: avdbackplane.applicationGroupType
      preferredAppGroupType: avdbackplane.preferredAppGroupType
      expirationtime: expirationtime
    }
  }
]

output hp1out string = backplanedeploy[1].outputs.hostPoolRegistrationtoken
