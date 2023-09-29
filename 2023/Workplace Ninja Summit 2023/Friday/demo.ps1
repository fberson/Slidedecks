#Logon with cred
$cred = Get-Credential
Connect-AzAccount -Credential $cred

#Logon with web
Connect-AzAccount
az login
Get-AzSubscription
Set-AzContext -SubscriptionId '6bee0596-7a91-4171-8e59-5c1af6dc65ed'

Get-AzSubscription
Get-AzResourceGroup | Select-Object ResourceGroupName

Import-Module Az
install-module Az

#Build a JSON file from Bicep
bicep build .\wvd-bicep-demo.bicep

#Deploy 2.main Bicep demo
New-AzResourceGroupDeployment -ResourceGroupName "Bicep-Workshop" -TemplateFile ".\2. main.bicep" -DeploymentName "Bicep-Workshop-demo-1"
az deployment group create --resource-group 'Bicep-Workshop' -f '.\2. main.bicep' --name "Bicep-Workshop-demo-1"
az deployment group what-if --resource-group 'Bicep-Workshop' -f '.\2. main.bicep' --name "Bicep-Workshop-demo-1"

#Deploy 4.VM Bicep demo
New-AzResourceGroupDeployment -ResourceGroupName "Bicep-Workshop" -TemplateFile ".\4. vm-bicep-demo.bicep" -DeploymentName "Bicep-Workshop-demo-2"
az deployment group create --resource-group 'Bicep-Workshop' -f '.\4. vm-bicep-demo.bicep' --name "Bicep-Workshop-demo-2"
az deployment group what-if --resource-group 'Bicep-Workshop' -f '.\4. vm-bicep-demo.bicep' --name "Bicep-Workshop-demo-2"

#Deploy 5.AVD Bicep demo
New-AzResourceGroupDeployment -ResourceGroupName "Bicep-Workshop" -TemplateFile ".\5. bicep-avd-demo.bicep" -DeploymentName "Bicep-Workshop-demo-3"
az deployment group create --resource-group 'Bicep-Workshop' -f '5. bicep-avd-demo.bicep' --name "Bicep-Workshop-demo-3"
az deployment group what-if --resource-group 'Bicep-Workshop' -f '5. bicep-avd-demo.bicep' --name "Bicep-Workshop-demo-3"

#Deploy 17.main.bicep
New-AzResourceGroupDeployment -ResourceGroupName "Bicep-Workshop" -TemplateFile ".\17. main.bicep" -DeploymentName "Bicep-Workshop-demo-4"
az deployment group create --resource-group 'Bicep-Workshop' -f '17. main.bicep' --name "Bicep-Workshop-demo-4"
az deployment group what-if --resource-group 'Bicep-Workshop' -f '17. main.bicep' --name "Bicep-Workshop-demo-4"

#Deploy 17.main.bicep
New-AzResourceGroupDeployment -ResourceGroupName "Bicep-Workshop" -TemplateFile ".\Samples\main-mcr.json" -DeploymentName "Bicep-Workshop-demo"



#Deploy to Azure
$scriptStartTime = get-date
New-AzDeployment -TemplateFile ".\6. main.bicep" -TemplateParameterFile ".\6. main.parameters.json" -DeploymentName "avd-bicep-modules-demo" -Location 'West Europe'
$scriptTotalTime = (get-date) - $scriptStartTime
Write-Host "*** Grand total time: "$scriptTotalTime.Minutes "Minute(s), " $scriptTotalTime.seconds "Seconds and " $scriptTotalTime.Milliseconds "Milleseconds"


#Deploy Bicep Files directly
az deployment sub create -f 'main.bicep' -l westeurope

#Install PSArm
Install-Module -Name PSArm -AllowPrerelease
$parameters = Get-Content ./psarm/wvd-backplane.parameters.json | ConvertFrom-Json
Publish-PSArmTemplate -Path ./psarm/wvd-backplane.psarm.ps1 -OutFile ./psarm/template.json -force -Parameters $parameters
New-AzResourceGroupDeployment -ResourceGroupName 'PSArm-WVD-Demo' -TemplateFile ./psarm/template.json

#Run Template Action & retreive status
Invoke-AzResourceAction -ResourceGroupName "BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType Microsoft.VirtualMachineImages/imageTemplates -ResourceName "BICEP-AVD-ID" -Action Run -Force
#Get latest status
(Get-AzResource –ResourceGroupName "BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType "Microsoft.VirtualMachineImages/imageTemplates" -Name "BICEP-AVD-ID").Properties.lastRunStatus
#Cancel running actions
Invoke-AzResourceAction -ResourceGroupName "BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType Microsoft.VirtualMachineImages/imageTemplates -ResourceName "BICEP-AVD-ID" -Action Cancel -force


#Clean up Image related stuff
Get-AzResource –ResourceGroupName "BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType "Microsoft.VirtualMachineImages/imageTemplates" -name 'BICEP-AVD-ID' | Remove-AzResource -Force
Get-AzResource –ResourceGroupName "BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType "Microsoft.Compute/galleries/images/versions" -name 'BICEP-AVD-ID' | Remove-AzResource -Force
Remove-AzGalleryImageDefinition -Name 'BICEP-AVD-ID' -ResourceGroupName 'BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG' -GalleryName 'BICEP_AVD_AIB' -Force
Remove-AzGallery -Name 'BICEP_AVD_AIB' -ResourceGroupName 'BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG' -Force






#Authorize keyvault for release pipeline in Azure Devops!
#https://dev.azure.com/freek0230/WVD%20Host%20Pool%20Maintenance/_release?definitionId=2&view=mine&_a=releases


#Clean up Bicep demo
Remove-AzVirtualNetworkPeering -Name 'peering-from-adds-vnet' -VirtualNetworkName 'WE-P-VNET-01' -ResourceGroupName 'WE-P-RG-NETWORK' -force
Get-AzResource –ResourceGroupName "BICEP-AVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType "Microsoft.VirtualMachineImages/imageTemplates" -name 'BICEP-AVD-ID' | Remove-AzResource -Force
Get-AzResource –ResourceGroupName "BICEP-AVD-DEMO-P-TEMPLATE-IMAGE-RG" -ResourceType "Microsoft.Compute/galleries/images/versions" -name 'BICEP-AVD-ID' | Remove-AzResource -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-A-BACKPLANE-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-BACKPLANE-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-FILESERVICES-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-TEMPLATE-VM-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-MONITORING-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-KEYVAULT-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-A-AVD-HOSTS-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-AVD-HOSTS-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-TEMPLATESPECS-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-SCALE-PLANS-RG' -Force
Remove-AzGalleryImageDefinition -Name 'BICEP-AVD-ID' -ResourceGroupName 'BICEP-AVD-DEMO-P-TEMPLATE-IMAGE-RG' -GalleryName 'BICEP_AVD_AIB' -Force
Remove-AzGallery -Name 'BICEP_AVD_AIB' -ResourceGroupName 'BICEP-AVD-DEMO-P-TEMPLATE-IMAGE-RG' -Force
Remove-AzResourceGroup -Name 'BICEP-AVD-DEMO-P-NETWORK-RG' -Force

#Create SIG Identity
$imageResourceGroup = "BICEP-AVD-DEMO-P-TEMPLATE-IMAGE-RG"
$identityName = "BICEP-AVD-DEMO-IDENTITY"
New-AzUserAssignedIdentity -ResourceGroupName $imageResourceGroup -Name $identityName
$identityNamePrincipalId = $(Get-AzUserAssignedIdentity -ResourceGroupName $imageResourceGroup -Name $identityName).PrincipalId

#Update wvd-aibRoleImageCreation.json with the correct imageRoleDefName!
# Create the role definition and grant it
New-AzRoleDefinition -InputFile  ./wvd-aibRoleImageCreation.json
New-AzRoleDefinition -InputFile  ./wvd-vnetRoleCreation.json
New-AzRoleAssignment -ObjectId $identityNamePrincipalId -RoleDefinitionName 'AIB202012' -Scope "/subscriptions/66869840-a086-41d1-84e9-cf66ac8a9a94/resourceGroups/BICEP-WVD-DEMO-P-TEMPLATE-IMAGE-RG"
get-AzRoleDefinition | Where-Object IsCustom -EQ true | Select-Object Name, IsCustom, Id
Remove-AzRoleDefinition -Name 'AIB202012'
Get-AzRoleAssignment | Where-Object IsCustom -EQ true | Select-Object RoleDefinitionName, RoleAssignmentId, Scope



#Working with Service Principals

#Create new service principal and ouput the info
$servicePrincipal = New-AzADServicePrincipal `
  -DisplayName WVDNinjaPipeline `
  -SkipAssignment
$plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
Write-Output "Service principal application ID: $($servicePrincipal.ApplicationId)"
Write-Output "Service principal key: $($plaintextSecret)"
Write-Output "Your Azure AD tenant ID: $((Get-AzContext).Tenant.Id)"

#Create new role assignment
New-AzRoleAssignment `
  -ApplicationId $($servicePrincipal.ApplicationId) `
  -RoleDefinitionName Contributor `
  -Scope '/subscriptions/66869840-a086-41d1-84e9-cf66ac8a9a94/resourceGroups/NINJA-WE-P-RG-WVD-BICEP-TEST' `
  -Description "The deployment pipeline needs to create resources here"

#Deploy test bicep file by using service principal
$credential = Get-Credential
Connect-AzAccount -ServicePrincipal `
  -Credential $credential `
  -Tenant  'c81a69fb-8e18-456b-8445-df216d9fe84a'
New-AzResourceGroupDeployment -ResourceGroupName 'NINJA-WE-P-RG-WVD-BICEP-TEST' -TemplateFile 'empty.bicep'


#Deploy new ACR
az deployment group create --name 'ACR' --resource-group 'BICEP-DEMO' -f '14. createACR.bicep'

#Get the login server name (acrdemofreek.azurecr.io)
az acr show --resource-group 'BICEP-DEMO' --name 'acrdemofreek'

#Publish files to registry
bicep publish '9.avd-module.bicep' --target br:acrdemofreek.azurecr.io/bicep/modules/storage:v1

#Test Module registry
az deployment sub create -f '14. main.bicep' -l westeurope --name 'Module-registry-test'


















#GitHubActions

$resourceGroupName = 'GitHubActionsDemo'

#Create resource group
az group create -n $resourceGroupName -l westeurope

#Generate deployment credentials
az ad sp create-for-rbac --name myGitHubCred --role contributor --scopes /subscriptions/66869840-a086-41d1-84e9-cf66ac8a9a94/resourceGroups/$resourceGroupName --sdk-auth

<#
  "clientId": "bfb8fdde-0b43-465c-9da7-10c486d562ba",
  "clientSecret": "VWZ.omioP7r_y9ZvHd2Op8ZB.pb0owA2Mx",
  "subscriptionId": "66869840-a086-41d1-84e9-cf66ac8a9a94",
  "tenantId": "c81a69fb-8e18-456b-8445-df216d9fe84a",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",       
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
#>




### Graph API ###
Clear-Host
az deployment group create -l westeurope -f '.\9.graph-api-demo.bicep' -n 'Graph-demo'

az deployment group create --resource-group 'BICEP-AVD-DEMO' --template-file .\9.graph-api-demo.bicep 



### Bicepparm files ###
New-AzResourceGroupDeployment -ResourceGroupName "Bicep-demo" `
-TemplateFile '22. bicep-param-example.bicep' `
-TemplateParameterFile '22. bicep-param-example.bicepparam'
-DeploymentName "Bicep-Workshop-demo-4"

az deployment group create --resource-group 'Bicep-demo' `
--template-file '22. bicep-param-example.bicep' `
--Parameters '22. bicep-param-example.bicepparam' `
--name "Bicep-Workshop-demo-4"







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
New-AzSubscriptionDeploymentStack -Name 'myAVDStack' `
  -Location 'westeurope' `
  -TemplateFile '.\25. main.bicep' `
  -ResourceGroupName 'bicepdemo'

 #Azure CLI to deploy Deployment Stack
az stack group create `
  --name 'myAVDStack' `
  --resource-group 'BICEP-AVD-DEMO' `
  --template-file '.\25. main.bicep' `
  --deny-settings-mode 'denyDelete' `
  #--delete-resources

  #Retreive deploy Deployment Stack
  az stack group show --name 'myAVDStack' --resource-group 'BICEP-AVD-DEMO' --output json


