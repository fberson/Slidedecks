targetScope = 'subscription'
param location string
param vnetname string
param subNetName string
param localAdminName string
param deployResourceGroup bool
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

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = if (deployResourceGroup) {
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

//Modules in Azure Container Registry (ACR)
@description('Private Registry Module that deploys a storage account')
module sa2 'br/CoreModules:avdhostpool:v1' = {
  name: 'sa2'
  scope: rg
  params: {
    applicationGroupType: 'Desktop'
    location: location
    preferredAppGroupType: 'Desktop'
  }
}

//Modules in Azure Verified Modules (AVM)
//aka.ms/AVM - Owned, developed & supported by Microsoft
module myAVMTest 'br/public:avm/res/desktop-virtualization/host-pool:0.3.0' = {
  scope: rg
  params: {
    name: 'AVM-hostpool'
    description: 'My Azure Verified Module Host Pool'
    hostPoolType: 'Personal'
    location: location
  }
}


//Code completion example



//Module with loops
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


output hp1out string = backplanedeploy[1].outputs.hostPoolRegistrationtoken
