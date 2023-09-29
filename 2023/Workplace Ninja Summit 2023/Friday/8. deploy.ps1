### Deployment Stacks ###
Set-ExecutionPolicy Bypass -Scope Process
Set-Location 'C:\Temp\Az'
./AzDeploymentStacksPrivatePreview.ps1
Import-Module Az.Resources

#Import preview
& "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\python.exe" -m pip install -e 'C:\Temp\Stacks_CLI_2.0\AzDeploymentStacksPrivatePreview\azure-mgmt-resource-23.0.0' --force-reinstall

#Change dirs
Set-Location 'C:\Users\freek\OneDrive\Bicep\Bicep Workshop'

#PowerShell to deploy Deployment Stack
New-AzSubscriptionDeploymentStack -Name 'myAVDStackDemo' `
  -Location 'westeurope' `
  -TemplateFile '.\8. main.bicep' `
  -ResourceGroupName 'bicepdemo'

 #Azure CLI to deploy Deployment Stack
az stack group create `
  --name 'myAVDStack' `
  --resource-group 'BICEP-AVD-DEMO' `
  --template-file '.\8. main.bicep' `
  --deny-settings-mode 'denyDelete' `
  #--delete-resources

  #Retreive deploy Deployment Stack
  az stack group show --name 'myAVDStack' --resource-group 'BICEP-AVD-DEMO' --output json