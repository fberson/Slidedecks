targetScope = 'subscription'
param location string = 'westeurope'
param deployResourceGroup bool = true

param avdControlPlanes array = [
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

@description('The ResourceGroup where AVD control plane will be deployed')
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = if (deployResourceGroup) {
  name: 'BICEP-LOOP-DEMO'
  location: location
}

@description('Private Registry Module that deploys an Azure Virtual Desktop Control plane')
module controlplaneDeploy 'br:acrdemofreek.azurecr.io/bicep/modules/storage:v1' = [for avdControlPlane in avdControlPlanes: {
  name: '${avdControlPlane.applicationGroupType}-deploy'
  scope: rg
  params: {
    location: rg.location
    namePrefix: 'Test'
  }
}]

@description('Private Registry Module that deploys an Azure Virtual Desktop Control plane')
module controlplaneDeployv2 'br/CoreModules:storage:v1' = [for avdControlPlane in avdControlPlanes: {
  name: '${avdControlPlane.applicationGroupType}-deploy'
  scope: rg
  params: {
    location: rg.location
    namePrefix: 'Test'
  }
}]

//@description('Contains the generated host pool registration token')
//output hp1out string = controlplaneDeploy[1].outputs.hostPoolRegistrationtoken
