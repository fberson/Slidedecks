// Example: Using fail() with AVM Key Vault module for secure AVD deployments
param keyVaultName string = 'avd-secrets'
param location string = 'eastus'
param enableSoftDelete bool = true
param enablePurgeProtection bool = false

// Fail if location is eastus and name does not start with eastus-
var keyVaultNameValidated = (location == 'eastus' && !startsWith(keyVaultName, 'eastus-'))
  ? fail('Our Key Vault names must always start with "eastus-" when location is eastus used in AVD environments.')
  : keyVaultName

// Fail if purge protection is not enabled when soft delete is enabled (security best practice)
var purgeProtectionValidated = (enableSoftDelete && !enablePurgeProtection)
  ? fail('Purge protection must be enabled when soft delete is enabled for Key Vaults used in AVD environments.')
  : enablePurgeProtection

module kv 'br/public:avm/res/key-vault/vault:0.13.3' = {
  name: 'avdKeyVault'
  params: {
    name: keyVaultNameValidated
    location: location
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: purgeProtectionValidated
  }
}
