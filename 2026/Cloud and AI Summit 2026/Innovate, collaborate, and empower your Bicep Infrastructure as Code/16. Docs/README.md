# 16. Docs

## Navigation

- [Resource Types](#resource-types)
- [Parameters](#parameters)
- [Outputs](#outputs)

## Resource Types

| Resource Type | Existing |
| :-- | :-- |
| `Microsoft.DesktopVirtualization/applicationGroups@2026-04-01-preview` | No |
| `Microsoft.DesktopVirtualization/hostPools@2026-04-01-preview` | No |
| `Microsoft.DesktopVirtualization/workspaces@2026-04-01-preview` | No |

## Parameters

| Name | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| `appgroupDesktopFriendlyName` | `string` | Yes |  |
| `appgroupName` | `string` | Yes |  |
| `appgroupRemoteAppFriendlyName` | `string` | Yes |  |
| `AVDbackplanelocation` | `string` | No |  |
| `createRemoteAppHostpool` | `bool` | Yes |  |
| `enableValiatioMode` | `bool` | Yes |  |
| `hostpoolFriendlyName` | `string` | Yes | Friendly name of the Azure Virtual Desktop host pool |
| `hostpoolName` | `string` | Yes | Name of the Azure Virtual Desktop host pool |
| `hostPoolType` | `string` | No |  |
| `loadBalancerType` | `string` | No |  |
| `preferredAppGroupType` | `string` | No |  |
| `workspaceName` | `string` | Yes |  |
| `workspaceNameFriendlyName` | `string` | Yes |  |

### `AVDbackplanelocation`

- Default value: `'eastus'`

### `hostPoolType`

- Default value: `'pooled'`

### `loadBalancerType`

- Default value: `'BreadthFirst'`

### `preferredAppGroupType`

- Default value: `'Desktop'`

## Outputs

| Name | Type | Description |
| :-- | :-- | :-- |
| `desktopAppGroupId` | `string` | The resource ID of the desktop application group |
| `hostpoolName` | `string` | The name of the host pool |
| `hostpoolResourceId` | `string` | The resource ID of the host pool |
| `registrationToken` | `string` | Host pool registration token (for VM domain join) |
| `remoteAppGroupId` | `string` | The resource ID of the remote app application group (if created) |
| `workspaceId` | `string` | The resource ID of the workspace |
| `workspaceName` | `string` | The name of the workspace |
