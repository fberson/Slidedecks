resource stg 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: 'mystorageaccount'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: this.existingResource().?properties.accessTier ?? 'Cold'
  }
}
