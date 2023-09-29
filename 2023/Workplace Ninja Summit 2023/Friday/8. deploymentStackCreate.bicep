resource ds 'Microsoft.Resources/deploymentStacks@2022-08-01-preview' = {
  name: 'myAVDStackDemo'
  properties: {
    denySettings: {
      mode: 'denyDelete'
    }
    actionOnUnmanage: {
      resources: 'detach'
      managementGroups: 'detach'
      resourceGroups: 'detach'
    }
    deploymentScope: 'BICEP-AVD-DEMO-STACK'
    templateLink: null
    }
  }
