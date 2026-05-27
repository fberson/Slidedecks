param location string = 'eastus'
param storageAccountName string = 'mystorageaccount'
param storageAccountSku string = 'Standard_LRS'
param storageAccountKind string = 'StorageV2' 

resource sa 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
}

output storageAccountId string = sa.id
