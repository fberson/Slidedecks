//User Defined Constraints Example

@maxValue(10)
param maxSessionLimit1 int

@validate(x => x % 2 == 0, 'maxSessionLimit2 must be an even number')
param maxSessionLimit2 int

@validate(x => x == maxSessionLimit1, 'maxSessionLimit3 must be equal to maxSessionLimit')
param maxSessionLimit3 int

param location string
param expirationtime string = utcNow('u')
param preferredAppGroupType string
var prefix = 'my-prefix'

resource hp 'Microsoft.DesktopVirtualization/hostPools@2025-03-01-preview' = {
  name: '${prefix}-hostpool-1'
  location: location
  properties: {
    hostPoolType: 'Pooled'
    preferredAppGroupType: preferredAppGroupType
    loadBalancerType: 'BreadthFirst'
    registrationInfo: {
      registrationTokenOperation: 'Update'
      expirationTime: dateTimeAdd(expirationtime, 'PT2H')
    }
    maxSessionLimit: maxSessionLimit1
    
  }
}


output hostPoolRegistrationtoken string = hp.properties.registrationInfo.token
output maxSessionLimit1 int = maxSessionLimit1
output maxSessionLimit2 int = maxSessionLimit2
output maxSessionLimit3 int = maxSessionLimit3
