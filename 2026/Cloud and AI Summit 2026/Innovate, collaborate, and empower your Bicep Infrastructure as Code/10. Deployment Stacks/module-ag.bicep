param AVDbackplanelocation string = 'westeurope'
param appgroupName string = 'BICEP-P-AVD-HP-AG'
param preferredAppGroupType string = 'Desktop'
param hostPoolArmPath string

resource ag 'Microsoft.DesktopVirtualization/applicationGroups@2024-04-03' = {
  name: appgroupName
  location: AVDbackplanelocation
  properties: {
    hostPoolArmPath: hostPoolArmPath
    applicationGroupType: preferredAppGroupType
  }
}

output agID string = ag.id
