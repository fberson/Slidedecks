param AVDbackplanelocation string = 'westeurope'
param workspaceName string = 'BICEP-P-AVD-HP-WS'
param applicationGroupID string

resource ws 'Microsoft.DesktopVirtualization/workspaces@2024-04-03' = {
  name: workspaceName
  location: AVDbackplanelocation
  properties: {
    applicationGroupReferences: [
      applicationGroupID
    ]
  }
}
