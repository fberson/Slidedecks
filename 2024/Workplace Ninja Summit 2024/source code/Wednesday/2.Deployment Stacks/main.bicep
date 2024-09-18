targetScope = 'subscription'

param numberofEnvironments int = 3

param hostpoolResourceGroup string = 'WPN-2024-BICEP-STACK-HP'
param applicationGroupResourceGroup string = 'WPN-2024-BICEP-STACK-AG'
param workspaceResourceGroup string = 'WPN-2024-BICEP-STACK-WS'

param AVDlocation string = 'westeurope'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'DepthFirst'
param hostpoolName string = 'BICEP-P-AVD-HP'
param appgroupName string = 'BICEP-P-AVD-HP-AG'
param workspaceName string = 'BICEP-P-AVD-HP-WS'
param preferredAppGroupType string = 'Desktop'
param AVDHostPoolfriendlyname string = 'updated friendlyname'
param enableValiatioMode bool = true

resource hprg 'Microsoft.Resources/resourceGroups@2024-03-01' existing = {
  name: hostpoolResourceGroup
}

resource wsrg 'Microsoft.Resources/resourceGroups@2024-03-01' existing = {
  name: workspaceResourceGroup
}

resource agrg 'Microsoft.Resources/resourceGroups@2024-03-01' existing = {
  name: applicationGroupResourceGroup
}

module hp 'module-hp.bicep' = [
  for i in range(1, numberofEnvironments): {
    scope: hprg
    name: 'hp${i}'
    params: {
      AVDbackplanelocation: AVDlocation
      AVDHostPoolfriendlyname: AVDHostPoolfriendlyname
      enableValiatioMode: enableValiatioMode
      hostpoolName: '${hostpoolName}${i}'
      hostPoolType: hostPoolType
      loadBalancerType: loadBalancerType
      preferredAppGroupType: preferredAppGroupType
    }
  }
]

module ws 'module-ws.bicep' = [
  for i in range(0, numberofEnvironments): {
    scope: wsrg
    name: 'ws${i+1}'
    params: {
      AVDbackplanelocation: AVDlocation
      workspaceName:'${workspaceName}${i+1}' 
      applicationGroupID: ag[i].outputs.agID
    }
  }
]

module ag 'module-ag.bicep' = [
  for i in range(0, numberofEnvironments): {
    scope: agrg
    name: 'ag${i+1}'
    params: {
      hostPoolArmPath: hp[i].outputs.hpid
      preferredAppGroupType: preferredAppGroupType
      appgroupName: '${appgroupName}${i+1}'
      AVDbackplanelocation: AVDlocation
    }
  }
]
