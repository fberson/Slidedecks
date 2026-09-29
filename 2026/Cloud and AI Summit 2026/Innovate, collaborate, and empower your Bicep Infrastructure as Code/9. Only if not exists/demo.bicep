param condition bool = false

//Conditional resource deployment
resource sa2 'Microsoft.Storage/storageAccounts@2025-01-01' = if (condition) {
  name: 'demoiceland'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

//Only iof not exists
@onlyIfNotExists()
resource sa 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: 'demoiceland'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
