// 1. String manipulation
var normalizedName = toLower(replace('My Production App', ' ', '-'))
resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: normalizedName
  location: 'westeurope'
  sku: {
    name: 'B1'  
  }
}

// 2. Deterministic resource naming
var storageAccountName = 'st${uniqueString('my-subscription', 'prod', 'westeurope')}'
resource storageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccountName
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output normalizedName string = normalizedName
output storageAccountName string = storageAccountName


// Build custom RDP property string with multiple settings
@export()
func buildRdpProperty(multimon bool, fullscreen bool, smartSizing bool, dynamicRes bool, width int, height int) string =>
  'use multimon:i:${multimon ? 1 : 0};screen mode id:i:${fullscreen ? 2 : 1};smart sizing:i:${smartSizing ? 1 : 0};dynamic resolution:i:${dynamicRes ? 1 : 0};desktopwidth:i:${width};desktopheight:i:${height}'


param myCustomRdpProperty string = buildRdpProperty(true, true, false, true, 1920, 1080)
  




