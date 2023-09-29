param localAdminName string
@secure()
param localAdminPassword string
param vnetName string
param subNetName string
param vmSku string = 'Standard_D4s_v4'
param vmOS string = '2019-Datacenter'
param numberofVMs int = 5

var defaultLocation = resourceGroup().location
var vmName = 'bicep-demo-vm'
var defaultVmNicName = '${vmName}-nic'
var privateIPAllocationMethod = 'Dynamic'

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' existing = {
  name: vnetName
}

resource vmNic 'Microsoft.Network/networkInterfaces@2023-04-01' = [for i in range(1, numberofVMs):{
  name: '${defaultVmNicName}-${i}'
  location: defaultLocation
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/${subNetName}'
          }
          privateIPAllocationMethod: privateIPAllocationMethod
        }
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}]

resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = [for i in range(1, numberofVMs):{
  name: '${vmName}-${i}'
  location: defaultLocation
  properties: {
    osProfile: {
      computerName: vmName
      adminUsername: localAdminName
      adminPassword: localAdminPassword
    }
    hardwareProfile: {
      vmSize: vmSku
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: vmOS
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: vmNic[i-1].id
        }
      ]
    }
  }
}]
