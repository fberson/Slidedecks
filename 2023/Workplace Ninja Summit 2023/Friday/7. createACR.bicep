@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string = 'acrdemofreek'

@description('Provide a location for the registry.')
param location string = 'west europe'

@description('Provide a tier of your Azure Container Registry.')
param acrSku string = 'Basic'

@description('Creates the Azure Container Registry')
resource acrResource 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}
