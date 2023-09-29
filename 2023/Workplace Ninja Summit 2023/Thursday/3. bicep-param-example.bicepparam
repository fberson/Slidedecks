using './3. bicep-param-example.bicep'

param hostpoolName = ''
param hostpoolFriendlyName = 'A demo host pool'
param preferredAppGroupType = 'Desktop'
param AVDbackplanelocation = 'eastus'
param hostPoolType = 'pooled'
param loadBalancerType = 'BreadthFirst'
param enableValiationMode = false
param maxSessionLimit = 10
param secretDescription = ''
param secretValue = ''

