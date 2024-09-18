targetScope = 'subscription'

//provider microsoftGraph
extension microsoftGraph

//Dynamic types
//extension microsoftGraphV10

param appRegistrationName string = 'WPN24'
param members array = [
  '0a7895e3-bc3b-47d9-a120-7ef4222cba6c'
  '56237416-4c32-49ef-9811-4ada3c6c2e94'
] 
param resourceGroupNameInfra string
param location string = 'west europe'

var contributorRoleDefinitionID = 'b24988ac-6180-42a0-ab88-20f7382dd24c'


//Graph API to create Group and assign members
@description('Example using Microsoft Graph API to create a group and asisgn members to it')
resource group 'Microsoft.Graph/groups@v1.0' = {
  uniqueName: 'WPN-Members'
  displayName: 'contributor Group WPN'
  mailEnabled: false
  mailNickname: 'WPNMembers'
  securityEnabled: true
  members: members
}
resource existingGroup 'Microsoft.Graph/groups@v1.0' existing = {uniqueName:'WPN-Members'}
output group string = existingGroup.displayName


//graph API to create app registration 
@description('Create a new app registration')
resource appRegistration 'Microsoft.Graph/applications@v1.0' = {
  displayName: appRegistrationName
  uniqueName: appRegistrationName
  passwordCredentials: [
    {
      displayName: 'password'
      endDateTime: '2099-01-01T00:00:00Z'
    }
  ]
}

//graph API to create service principal
@description('Create a new service principal')
resource resourceSp 'Microsoft.Graph/servicePrincipals@v1.0' = {
  appId: appRegistration.appId
}

//Create a new resource group
@description('Create a new resource group')
resource rginfra 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupNameInfra
  location: location
}

//Assign the service principal contributor permisions to the resource group
@description('Assign the service principal contributor permisions to the resource group')
module resourceGroupNameInfraPermission './Modules/module-resourceGroupPermissions.bicep' = {
  scope: rginfra
  name: 'resourceGroupNameInfraPermission'
  params: {
    principalId: resourceSp.id
    contributorRoleDefinitionID: contributorRoleDefinitionID
    appRegistrationName: appRegistrationName
  }
  dependsOn: [
    sleep
  ]
}

@description('Ensure the sevice principal is created before proceeding')
module sleep './Modules/module-sleep.bicep' = {
  scope: rginfra
  name: 'sleep'
  params: {
    sleepTime: 30
  }
  dependsOn: [
    appRegistration
    resourceSp
  ]
}
