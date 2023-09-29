param scalingPlanName string
param scalingPlanDescription string = ''
param location string
param friendlyName string = ''
@allowed(['Pooled', 'Personal'])
param hostPoolType string
param timeZone string
param schedules array
param hostpoolReferences array = []
param exclusionTag string = ''
param tags object = {}

resource sp 'Microsoft.DesktopVirtualization/scalingPlans@2022-10-14-preview' = {
  name: scalingPlanName
  location: location
  tags: tags
  properties: {
    friendlyName: friendlyName
    description: scalingPlanDescription
    hostPoolType: hostPoolType
    timeZone: timeZone
    exclusionTag: exclusionTag
    schedules: null
    hostPoolReferences: hostpoolReferences
  }
}

resource sps1 'Microsoft.DesktopVirtualization/scalingPlans/pooledSchedules@2022-10-14-preview' = [
  for item in schedules: if ((hostPoolType == 'Pooled')) {
    parent: sp
    name: '${item.name}'
    properties: item
  }
]

