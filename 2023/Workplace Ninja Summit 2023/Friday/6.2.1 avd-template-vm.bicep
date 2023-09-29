//Define AVD Template Image deployment parameters
param vmname string
param vmHostname string
param vmLocation string = 'westeurope'
param vmSize string
param adminUserName string
@secure()
param adminPassword string
param vnetid string
param subnetName string
var nicName = '${vmname}-nic'
var subnetRef = '${vnetid}/subnets/${subnetName}'

resource nic 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: nicName
  location: vmLocation

  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
  }
}

//Create AVD Template Image VM
resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmname
  location: vmLocation
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmHostname
      adminUsername: adminUserName
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'microsoftwindowsdesktop'
        offer: 'windows-11'
        sku: 'win11-22h2-avd'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: '${vmname}-osdisk'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
