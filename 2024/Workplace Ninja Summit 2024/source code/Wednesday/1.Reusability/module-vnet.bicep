param vnetName string = 'bicep-demo-vnet'
param vnetLocation string = 'west europe'
param subNetName string = 'bicep-demo-subnet'

var vnetConfig = {
  vnetprefix: '10.0.0.0/16'
  subnet: {
    name: subNetName
    subnetPrefix: '10.0.66.0/24'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: vnetLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetConfig.vnetprefix
      ]
    }
    subnets: [
      {
        name: vnetConfig.subnet.name
        properties: {
          addressPrefix: vnetConfig.subnet.subnetPrefix
        }
      }
    ]
  }
}
