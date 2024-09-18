using 'a. User-Defined_Types-2.bicep'
param hostpoolconfigs = [
  {
    name: 'AVDHostPool1'
    location: 'westeurope'
    descriptionHP: 'My first host pool'
    friendlyName: 'My first host pool'
    hostPoolType: 'Personal'
    loadBalancerType: 'BreadthFirst'
    managementType: 'automated' 
    maxSessionLimit: 666
    preferredAppGroupType: 'RailApplications' 
    startVMOnConnect: true
    validationEnvironment:false 
  }
]
