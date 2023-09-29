#Deploy to Azure
$scriptStartTime = get-date
az deployment sub create -f '6. main.bicep' --name "avd-bicep-modules-dem" -p '.\6. main.bicepparam' -l 'westeurope'
$scriptTotalTime = (get-date) - $scriptStartTime
Write-Host "*** Grand total time: "$scriptTotalTime.Minutes "Minute(s), " $scriptTotalTime.seconds "Seconds and " $scriptTotalTime.Milliseconds "Milleseconds"