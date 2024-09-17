function ConvertTo-RawIcon {
    [CmdletBinding()]

    Param (
        [Parameter(
            Position = 0,
            ValuefromPipelineByPropertyName = $true,
            ValuefromPipeline = $true,
            Mandatory = $true
        )]
        [Alias('FullName')]
        [System.String]$Path
    )

    begin {
        Set-StrictMode -Version Latest
    } # begin
    process {

        if (Test-Path $Path){
            $fileInfo = Get-ChildItem $Path
        }
        else{
            Write-Error "$Path not found"
        }

        if ($fileInfo.Extension -ne '.png') {
            Write-Error "Only support png"
            return
        }


        $Bytes = get-content $Path -AsByteStream -Raw
        $inputFromBase64conv = [convert]::ToBase64String($Bytes)
        $out = [System.Convert]::FromBase64String($inputFromBase64conv)

        Write-Output $out
        
    } # process
    end {} # end
}  #function ConvertTo-RawIcon