using Microsoft.AspNetCore.Builder;
using Bicep.Local.Extension.Host.Extensions;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder();

builder.AddBicepExtensionHost(args);
builder.Services
    .AddBicepExtension(
        name: "HomeAssist",
        version: "0.1.0",
        isSingleton: true,
        typeAssembly: typeof(Program).Assembly)
    .WithResourceHandler<LightHandler>();

var app = builder.Build();

app.MapBicepExtension();

await app.RunAsync();
