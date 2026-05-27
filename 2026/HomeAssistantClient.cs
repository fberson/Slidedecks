using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

public class HomeAssistantClient
{
    private readonly HttpClient _httpClient;
    private readonly string _baseUrl;
    private readonly string _accessToken;

    public HomeAssistantClient(string baseUrl, string accessToken)
    {
        _baseUrl = baseUrl.TrimEnd('/');
        _accessToken = accessToken;
        _httpClient = new HttpClient();
        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", _accessToken);
        _httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
    }

    public async Task<EntityState?> GetEntityStateAsync(string entityId, CancellationToken cancellationToken = default)
    {
        try
        {
            var response = await _httpClient.GetAsync($"{_baseUrl}/api/states/{entityId}", cancellationToken);
            response.EnsureSuccessStatusCode();

            var content = await response.Content.ReadAsStringAsync(cancellationToken);
            return JsonSerializer.Deserialize<EntityState>(content);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error getting entity state: {ex.Message}");
            return null;
        }
    }

    public async Task<bool> TurnOnLightAsync(string entityId, int? brightness = null, int colorTemp = 0, int hue = -1, int saturation = -1, CancellationToken cancellationToken = default)
    {
        var serviceData = new Dictionary<string, object>
        {
            ["entity_id"] = entityId
        };

        if (brightness.HasValue)
        {
            serviceData["brightness"] = brightness.Value;
        }

        if (colorTemp > 0)
        {
            serviceData["color_temp"] = colorTemp; // prefer color temperature if provided
        }
        else if (hue >= 0 && saturation >= 0)
        {
            serviceData["hs_color"] = new List<int> { hue, saturation };
        }

        return await CallServiceAsync("light", "turn_on", serviceData, cancellationToken);
    }


    private async Task<bool> CallServiceAsync(string domain, string service, Dictionary<string, object> serviceData, CancellationToken cancellationToken = default)
    {
        try
        {
            var json = JsonSerializer.Serialize(serviceData);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"{_baseUrl}/api/services/{domain}/{service}", content, cancellationToken);
            if (!response.IsSuccessStatusCode)
            {
                var body = await response.Content.ReadAsStringAsync(cancellationToken);
                Console.WriteLine($"Service call failed: {(int)response.StatusCode} {response.StatusCode}. Body: {body}");
                return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error calling service {domain}.{service}: {ex.Message}");
            return false;
        }
    }

    public async Task<bool> TurnOffLightAsync(string entityId, CancellationToken cancellationToken = default)
    {
        var serviceData = new Dictionary<string, object>
        {
            ["entity_id"] = entityId
        };

        return await CallServiceAsync("light", "turn_off", serviceData, cancellationToken);
    }

}

public class EntityState
{
    [JsonPropertyName("entity_id")]
    public string EntityId { get; set; } = string.Empty;

    [JsonPropertyName("state")]
    public string State { get; set; } = string.Empty;

    [JsonPropertyName("attributes")]
    public Dictionary<string, JsonElement> Attributes { get; set; } = new();

    [JsonPropertyName("last_changed")]
    public DateTime LastChanged { get; set; }

    [JsonPropertyName("last_updated")]
    public DateTime LastUpdated { get; set; }
}
