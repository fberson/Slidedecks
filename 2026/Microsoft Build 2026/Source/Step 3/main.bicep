targetScope = 'local'
extension homeassist

@secure()
@description('Home Assistant long-lived access token')
param accessToken string

@description('Home Assistant instance URL')
param homeAssistantUrl string = ''

@description('The entity ID of the light to control')
param lightEntityId string = 'light.aqara_lumi_light_agl003'

@description('Desired state of the light')
@allowed(['on', 'off'])
param lightState string = 'on'

@description('Brightness level (0-255)')
@minValue(0)
@maxValue(255)
param brightness int = 100

@description('Color temperature mireds (153-500, 0 to skip)')
@minValue(0)
@maxValue(500)
param colorTemp int = 0

@description('Hue 0-360 (-1 to skip)')
@minValue(-1)
@maxValue(360)
param hue int = -1

@description('Saturation 0-100 (-1 to skip)')
@minValue(-1)
@maxValue(100)
param saturation int = -1

resource aqaraLight 'Light' = {
  entityId: lightEntityId
  homeAssistantUrl: homeAssistantUrl
  accessToken: accessToken
  state: lightState
  brightness: brightness
  colorTemp: colorTemp
  hue: hue
  saturation: saturation
}

output currentState string = aqaraLight.currentState
output friendlyName string = aqaraLight.friendlyName
output entityId string = aqaraLight.entityId
