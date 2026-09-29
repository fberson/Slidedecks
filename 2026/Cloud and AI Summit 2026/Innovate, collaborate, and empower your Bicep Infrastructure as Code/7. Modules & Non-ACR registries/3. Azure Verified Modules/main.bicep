// Browse module registry
// https://azure.github.io/Azure-Verified-Modules/indexes/bicep/


// VSCode intellisense example

// large example of an AVM 
@description('Scalable environment for deploying AI applications on Azure. ') 
module baseline 'br/public:avm/ptn/ai-platform/baseline:0.6.5' = {
  name: 'baselineDeployment'
  params: {
    // Required parameters
    name: 'aipbmax'
    // Non-required parameters
    applicationInsightsConfiguration: {
      name: 'appi-aipbmax'
    }
    bastionConfiguration: {
      disableCopyPaste: true
      enabled: true
      enableFileCopy: true
      enableIpConnect: true
      enableKerberos: true
      enableShareableLink: true
      name: 'bas-aipbmax'
      networkSecurityGroupResourceId: '<networkSecurityGroupResourceId>'
      scaleUnits: 3
      sku: 'Standard'
      subnetAddressPrefix: '10.1.1.0/26'
    }
    containerRegistryConfiguration: {
      name: 'craipbmax'
      trustPolicyStatus: 'disabled'
    }
    keyVaultConfiguration: {
      enablePurgeProtection: false
      name: '<name>'
    }
    logAnalyticsConfiguration: {
      name: 'log-aipbmax'
    }
    managedIdentityName: '<managedIdentityName>'
    storageAccountConfiguration: {
      allowSharedKeyAccess: true
      name: 'staipbmax'
      sku: 'Standard_GRS'
    }
    virtualMachineConfiguration: {
      adminPassword: '<adminPassword>'
      adminUsername: 'localAdminUser'
      enableAadLoginExtension: true
      enableAzureMonitorAgent: true
      enabled: true
      encryptionAtHost: false
      imageReference: {
        offer: 'dsvm-win-2022'
        publisher: 'microsoft-dsvm'
        sku: 'winserver-2022'
        version: 'latest'
      }
      maintenanceConfigurationResourceId: '<maintenanceConfigurationResourceId>'
      name: '<name>'
      nicConfigurationConfiguration: {
        ipConfigName: 'ipcfg-aipbmax'
        name: 'nic-aipbmax'
        networkSecurityGroupResourceId: '<networkSecurityGroupResourceId>'
        privateIPAllocationMethod: 'Dynamic'
      }
      osDisk: {
        caching: 'ReadOnly'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 256
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: 'disk-aipbmax'
      }
      patchMode: 'AutomaticByPlatform'
      size: 'Standard_DS1_v2'
      zone: 0
    }
    virtualNetworkConfiguration: {
      addressPrefix: '10.1.0.0/16'
      enabled: true
      name: 'vnet-aipbmax'
      subnet: {
        addressPrefix: '10.1.0.0/24'
        name: 'snet-aipbmax'
        networkSecurityGroupResourceId: '<networkSecurityGroupResourceId>'
      }
    }
    workspaceConfiguration: {
      computes: [
        {
          computeType: 'ComputeInstance'
          description: 'Default'
          location: '<location>'
          name: '<name>'
          properties: {
            vmSize: 'STANDARD_DS11_V2'
          }
          sku: 'Standard'
        }
      ]
      name: 'hub-aipbmax'
      networkIsolationMode: 'AllowOnlyApprovedOutbound'
      networkOutboundRules: {
        rule1: {
          category: 'UserDefined'
          destination: 'pypi.org'
          type: 'FQDN'
        }
      }
      projectName: 'project-aipbmax'
    }
  }
}

@export()
type storageAccountSkuType = 'Standard_LRS' | 'Standard_GRS'

@export()
type storageAccountKind = 'StorageV2' | 'Storage'

@export()
type storageAccountConfigType = {
  name: string
  sku: storageAccountSkuType
  kind: storageAccountKind
}
