function Convert-PngToBase64String {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PngFilePath
    )

    # Ensure the file exists
    if (-Not (Test-Path -Path $PngFilePath)) {
        throw "File '$PngFilePath' not found."
    }

    # Read the file content as bytes
    $byteArray = [System.IO.File]::ReadAllBytes($PngFilePath)

    # Convert the byte array to a Base64 string
    $base64String = [Convert]::ToBase64String($byteArray)

    return $base64String
}

