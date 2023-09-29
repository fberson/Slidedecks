# prerequisite: local install Azure CLI (2.20.0 or later)
az version

# connect to Azure (interactive)
az login

# set a subscription to be the current active subscription
az account set --name 'Visual Studio Enterprise'

# deploy to resourcegroup
az deployment group create --resource-group '_rg-WPNS-demo' `
                            --template-file 'deployCLI.bicep' `
                            --parameters hostpoolName='hp-demo-wpns-cli'
