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

@onlyIfNotExists()
resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = if (deployResourceGroup) {
  name: 'BICEP-LOOP-DEMO'
  location: location
}

//Modules in Azure Container Registry (ACR)
module avdhp 'br:acrbuild2025.azurecr.io/bicep/modules/avdhostpool:v1' = [
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

module avdvm 'br:acrbuild2025.azurecr.io/bicep/modules/avdvirtualmachine:v1' = {
  name: 'avdvm'
  scope: rg
  params: {
    localAdminName: localAdminName
    localAdminPassword: localAdminPassword
    vnetName: vnetname
    subNetName: subNetName
    defaultLocation: location
  }
}

module avdvnet 'br:acrbuild2025.azurecr.io/bicep/modules/avdvirtualnetwork:v1' = {
  name: 'avdvnet'
  scope: rg
  params: {
    vnetLocation: location
    vnetName: vnetname
    subNetName: subNetName
  }
}


