using Bicep.Local.Extension.Host.Handlers;

public class LightHandler : TypedResourceHandler<Light, LightIdentifiers>
{
    protected override async Task<ResourceResponse> Preview(ResourceRequest request, CancellationToken cancellationToken)
    {
        return GetResponse(request);
    }

    protected override LightIdentifiers GetIdentifiers(Light properties)
        => new()
        {
            EntityId = properties.EntityId,
        };

    protected override async Task<ResourceResponse> CreateOrUpdate(ResourceRequest request, CancellationToken cancellationToken)
    {
        var client = new HomeAssistantClient(request.Properties.HomeAssistantUrl, request.Properties.AccessToken);
        
        bool success;
        if (request.Properties.State.Equals("on", StringComparison.OrdinalIgnoreCase))
        {
            int? brightness = request.Properties.Brightness > 0 ? request.Properties.Brightness : null;
            success = await client.TurnOnLightAsync(
                request.Properties.EntityId,
                brightness,
                request.Properties.ColorTemp,
                request.Properties.Hue,
                request.Properties.Saturation,
                cancellationToken);
        }
        else if (request.Properties.State.Equals("off", StringComparison.OrdinalIgnoreCase))
        {
            success = await client.TurnOffLightAsync(request.Properties.EntityId, cancellationToken);
        }
        else
        {
            throw new InvalidOperationException($"Invalid state '{request.Properties.State}'. Must be 'on' or 'off'.");
        }

        if (!success)
        {
            throw new InvalidOperationException($"Failed to set light state to '{request.Properties.State}'");
        }

        await Task.Delay(500, cancellationToken);

        var state = await client.GetEntityStateAsync(request.Properties.EntityId, cancellationToken);
        if (state != null)
        {
            request.Properties.CurrentState = state.State;
            
            if (state.Attributes.TryGetValue("friendly_name", out var friendlyName))
            {
                request.Properties.FriendlyName = friendlyName.GetString();
            }
        }

        return GetResponse(request);
    }


}
