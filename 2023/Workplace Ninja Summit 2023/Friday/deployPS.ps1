# prerequisite: local install Azure PowerShell Module (5.6.0 or later)
Get-Module -Name Az -ListAvailable
# prerequisite: local install Bicep CLI
bicep.exe --version
# prerequisite: connect to Azure (interactive)
Connect-AzAccount | Out-Null
# prerequisite: set a subscription to be the current active subscription
$subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise'
Select-AzSubscription -SubscriptionObject $subscription | Out-Null

# deploy to resourcegroup, using Az PowerShell Module
$params = @{
    hostpoolName = 'hp-demo-wpns-ps'
}
New-AzResourceGroupDeployment -ResourceGroupName '_rg-WPNS-demo' -TemplateFile 'deployCLI.bicep' `
                            -TemplateParameterObject $params

