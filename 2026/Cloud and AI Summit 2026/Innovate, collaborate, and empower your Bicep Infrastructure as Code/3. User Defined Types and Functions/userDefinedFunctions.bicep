//default functions
var test = min(1,2,3)  
var test2 = contains('St. Charles', 'e')


// Build custom RDP property string with multiple settings
@export()
func buildRdpProperty(multimon bool, fullscreen bool, smartSizing bool, dynamicRes bool, width int, height int) string =>
  'use multimon:i:${multimon ? 1 : 0};screen mode id:i:${fullscreen ? 2 : 1};smart sizing:i:${smartSizing ? 1 : 0};dynamic resolution:i:${dynamicRes ? 1 : 0};desktopwidth:i:${width};desktopheight:i:${height}'

// Using Bicep Console feature
// .\bicep.exe console
// [buildRdpProperty(true, true, false, true, 1920, 1080)]

param hostPoolName string = 'demoHostPool'

// Choose your settings here
param multimon bool = true
param fullscreen bool = true
param smartSizing bool = false
param dynamicRes bool = true
param width int = 1920
param height int = 1080

resource avdHostPool 'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview' = {
  name: hostPoolName
  location: 'eastus'
  properties: {
    hostPoolType: 'Pooled'
    preferredAppGroupType: 'Desktop'
    loadBalancerType: 'BreadthFirst'
    customRdpProperty: buildRdpProperty(multimon, fullscreen, smartSizing, dynamicRes, width, height)
  }
}

output test int = test
output test2 bool = test2
