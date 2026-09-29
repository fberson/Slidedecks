using './main.bicep'

param AVDbackplanelocation = 'westeurope'
param hostPoolType = 'pooled'
param loadBalancerType = 'DepthFirst'
param hostpoolName = 'BICEP-P-AVD-HP'
param appgroupName = 'BICEP-P-AVD-HP-AG'
param workspaceName = 'BICEP-P-AVD-HP-WS'
param preferredAppGroupType = 'Desktop'
param AVDHostPoolfriendlyname = 'updated friendlyname'
param enableValiatioMode = true
param createRemoteAppHostpool = true

