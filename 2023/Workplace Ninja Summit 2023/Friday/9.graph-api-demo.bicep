//https://github.com/microsoftgraph/msgraph-bicep-types
import 'microsoftGraph@1.0.0'

@description('Id of the application role to add to the resource app')
param appRoleId string = '5b567255-7703-4780-807c-7be8301ae99b'

resource resourceApp 'Microsoft.Graph/applications@beta' = {
  name: 'ExampleResourceApp'
  displayName: 'Example Resource Application'
  appRoles: [
    {
      id: appRoleId
      allowedMemberTypes: [ 'User', 'Application' ]
      description: 'Read access to resource app data'
      displayName: 'ResourceAppData.Read.All'
      value: 'ResourceAppData.Read.All'
      isEnabled: true
    }
  ]
}

//resource resourceSp 'Microsoft.Graph/servicePrincipals@beta' = {
//  appId: resourceApp.appId
//}

//resource clientApp 'Microsoft.Graph/applications@beta' = {
//  name: 'ExampleClientApp'
//  displayName: 'Example Client Application'
//}

//resource clientSp 'Microsoft.Graph/servicePrincipals@beta' = {
//  appId: clientApp.appId
//}

