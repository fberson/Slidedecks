param location string = resourceGroup().location

module storage 'br:ghcr.io/fberson/modules/storage:v1' = {
  name: 'storage'
  params: {
    name: 'st${uniqueString(resourceGroup().id)}'
    location: location
  }
}

output storageId string = storage.outputs.id
