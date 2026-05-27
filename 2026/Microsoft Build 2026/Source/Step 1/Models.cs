using System.Text.Json.Serialization;
using Azure.Bicep.Types.Concrete;
using Bicep.Local.Extension.Types.Attributes;

public class LightIdentifiers
{
    [TypeProperty("The Home Assistant entity ID", ObjectTypePropertyFlags.Identifier | ObjectTypePropertyFlags.Required)]
    public required string EntityId { get; set; }
}

[ResourceType("Light")]
public class Light : LightIdentifiers
{
    [TypeProperty("The Home Assistant instance URL", ObjectTypePropertyFlags.Required)]
    public required string HomeAssistantUrl { get; set; }

    [TypeProperty("The Home Assistant long-lived access token", ObjectTypePropertyFlags.Required)]
    [JsonPropertyName("accessToken")]
    public required string AccessToken { get; set; }

    [TypeProperty("Desired state of the light (on/off)", ObjectTypePropertyFlags.Required)]
    public required string State { get; set; }

    [TypeProperty("Brightness level (0-255). Use 0 to skip setting brightness.", ObjectTypePropertyFlags.None)]
    public int Brightness { get; set; } = 0;

    [TypeProperty("Color temperature in mireds (0 to skip). Typical range 153-500.", ObjectTypePropertyFlags.None)]
    public int ColorTemp { get; set; } = 0;

    [TypeProperty("Hue 0-360 degrees (-1 to skip).", ObjectTypePropertyFlags.None)]
    public int Hue { get; set; } = -1;

    [TypeProperty("Saturation 0-100 percent (-1 to skip).", ObjectTypePropertyFlags.None)]
    public int Saturation { get; set; } = -1;

    [TypeProperty("Current state from Home Assistant")]
    public string? CurrentState { get; set; }

    [TypeProperty("Friendly name of the entity")]
    public string? FriendlyName { get; set; }
}
