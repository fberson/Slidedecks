# 1. Build the project
Write-Host "`nBuilding project..." -ForegroundColor Yellow
dotnet build HomeAssistExtension.csproj --configuration Release

# 2. Publish for Windows x64
Write-Host "`nPublishing for Windows x64..." -ForegroundColor Yellow
dotnet publish HomeAssistExtension.csproj --configuration Release -r win-x64

# 3. Publish the Bicep extension locally
Write-Host "`nPublishing extension locally..." -ForegroundColor Yellow
.\bicep.exe publish-extension `
    --bin-win-x64 .\bin\Release\net9.0\win-x64\bicep-ext-homeassist.exe `
    --target .\bin\bicep-ext-homeassist `
    --force

# -OR-

# 3. Publish the Bicep extension in ACR
Write-Host "`nPublishing extension in ACR..." -ForegroundColor Yellow
.\bicep.exe publish-extension `
    --bin-win-x64 .\bin\Release\net9.0\win-x64\bicep-ext-homeassist.exe `
    --target  br:<path_to_acr:v1 `
    --force

Write-Host "`nBuild complete!" -ForegroundColor Green
Write-Host "Extension published to: .\bin\bicep-ext-homeassist" -ForegroundColor Cyan
Write-Host "`nTo deploy, run: az bicep local-deploy main.bicepparam" -ForegroundColor Cyan
