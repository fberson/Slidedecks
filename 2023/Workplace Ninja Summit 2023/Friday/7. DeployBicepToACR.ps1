#Deploy new ACR
az deployment group create --name 'ACR' --resource-group 'BICEPDEMO' -f '7. createACR.bicep'

#Get the login server name (acrdemofreek.azurecr.io)
az acr show --resource-group 'BICEP-DEMO' --name 'acrdemofreek'

#Publish files to registry
az bicep publish --file '.\7. avd-module.bicep' --target 'br:acrdemofreek.azurecr.io/bicep/modules/storage:v1'

#Test Module registry
az deployment sub create -f '14. main.bicep' -l westeurope --name 'Module-registry-test'
