// CTRL - i
targetScope = 'subscription'
param location string = 'westeurope'
param vnetname string = 'myvnet'
param subNetName string = 'bicep-demo-subnet'
param localAdminName string
param deployResourceGroup bool = true

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

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = if (deployResourceGroup) {
  name: 'BICEP-LOOP-DEMO'
  location: location
}

module vnet  '8.vnet-module.bicep' = {
  scope: rg
  name: 'vnet'
  params: {
    vnetLocation: location
    vnetName: vnetname
    subNetName: subNetName    
  }
}

module vm '8.vm-loop-module.bicep' = {
  name: 'VM'
  scope: rg
  params: {
    localAdminName: localAdminName
    localAdminPassword: localAdminPassword
    vnetName: vnetname
    subNetName: subNetName
  }
}

module backplanedeploy '8.avd-module.bicep' = [for avdbackplane in avdbackplanes: {
  name: '${avdbackplane.applicationGroupType}-deploy'
  scope: rg
  params: {
    location: rg.location
    prefix: avdbackplane.postfix
    applicationGroupType: avdbackplane.applicationGroupType
    preferredAppGroupType: avdbackplane.preferredAppGroupType
  }
}]

output hp1out string = backplanedeploy[1].outputs.hostPoolRegistrationtoken

