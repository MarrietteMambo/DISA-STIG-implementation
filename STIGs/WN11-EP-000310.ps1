<#
.SYNOPSIS
    This script enforces Kernel DMA Protection by setting DeviceEnumerationPolicy to 0 in the registry, supporting compliance with STIG WN11-EP-000310.
    

.NOTES
    Author          : Marriette Mambo
    LinkedIn        : linkedin.com/in/marriette-mambo/
    GitHub          : github.com/MarrietteMambo
    Date Created    : 04-18-26
    Last Modified   : 04-18-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000310
    Documentation   : https://stigaview.com/products/win11/v2r3/WN11-CC-000310/

.TESTED ON
    Date(s) Tested  : 04-17-26
    Tested By       : Marriette Mambo
    Systems Tested  : 
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000310.ps1 
#>

function Set-STIG-WN11-EP-000310 {
    [CmdletBinding()]
    param ()

    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection"
    $valueName = "DeviceEnumerationPolicy"
    $valueData = 0

    try {
        Write-Host "Configuring Kernel DMA Protection policy..." -ForegroundColor Cyan

        # Ensure registry path exists
        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }

        # Create or update the registry value
        New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value $valueData -Force | Out-Null

        Write-Host "Configuration complete." -ForegroundColor Green

        # Verify the setting
        Write-Host "`nVerification:" -ForegroundColor Yellow
        Get-ItemProperty -Path $regPath -Name $valueName | Select-Object $valueName
    }
    catch {
        Write-Error "Failed to configure STIG WN11-EP-000310. $_"
    }
}

# Execute the function
Set-STIG-WN11-EP-000310
