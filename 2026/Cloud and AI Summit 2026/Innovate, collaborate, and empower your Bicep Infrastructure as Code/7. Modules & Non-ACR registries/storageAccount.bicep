// storage.bicep

param name string
param location string = resourceGroup().location

resource storage 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output id string = storage.id
