param vnetName string
param remoteVnetName string
param vnetNameResourceGroup string

//Create peering from adds to Bicep vnet
resource peertfromadds 'microsoft.network/virtualNetworks/virtualNetworkPeerings@2023-04-01' = {
  name: '${remoteVnetName}/peering-from-adds-vnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(vnetNameResourceGroup, 'Microsoft.Network/virtualNetworks', vnetName)
    }
  }
}
