targetScope = 'resourceGroup'

param location string = resourceGroup().location
param vaultName string = 'kv-${uniqueString(resourceGroup().id)}'
param keyMgmtRoleDefinitionGuid string = '00482a5a-887f-4fb3-b363-3b7fe8e74483'

// Build the full roleDefinitionId
var keyMgmtRoleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', keyMgmtRoleDefinitionGuid)

// Use deployer() for identity + traceability
var principalObjectId = deployer().objectId
var tags = {
  deployedByObjectId: principalObjectId
  deployedByName:     deployer().userPrincipalName
  purpose:            'KV demo: add deployer as key management admin via RBAC'
}

resource kv 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: vaultName
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    // RBAC mode so roleAssignments control data-plane access
    enableRbacAuthorization: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

// Assign the deployer as the chosen Key Management admin role on the vault
resource raKeyMgmt 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(kv.id, 'keymgmt-admin', principalObjectId)
  scope: kv
  properties: {
    roleDefinitionId: keyMgmtRoleDefinitionId
    principalId: principalObjectId
    // principalType omitted for portability (user vs service principal)
  }
}

// Handy outputs for demo
output keyVaultId string = kv.id
output keyVaultName string = kv.name

// The portal shows this as the UPN/display name for users (or SP display name). 
// Expose it under the name the audience expects: "userPrincipalName".
output deployerUserPrincipalName string = deployer().userPrincipalName
output deployerObjectId string = principalObjectId
