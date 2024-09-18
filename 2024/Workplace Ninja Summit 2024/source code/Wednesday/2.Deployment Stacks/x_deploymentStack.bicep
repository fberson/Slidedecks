resource ds 'Microsoft.Resources/deploymentStacks@2024-03-01' = {
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
    deploymentScope: 'WPN-2024-BICEP-STACK'
    templateLink: {
      relativePath: './1.Deployment Stacks/main.bicep'
    }
    }
  }
