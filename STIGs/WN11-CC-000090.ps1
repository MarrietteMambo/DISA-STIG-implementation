<#
.SYNOPSIS
    This PowerShell script creates the required Group Policy registry path if it does not exist and sets the NoGPOListChanges value to 0 as a REG_DWORD under HKEY_LOCAL_MACHINE. It helps enforce the required Windows policy configuration for compliance.

.NOTES
    Author          : Marriette Mambo
    LinkedIn        : linkedin.com/in/marriette-mambo/
    GitHub          : github.com/MarrietteMambo
    Date Created    : 04-18-26
    Last Modified   : 04-18-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090
    Documentation   : https://stigaview.com/products/win11/v1r6/WN11-CC-000090/

.TESTED ON
    Date(s) Tested  : 04-18-26
    Tested By       : Marriette Mambo
    Systems Tested  : 
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000090.ps1 
#>

function Set-NoGPOListChangesPolicy {
    [CmdletBinding()]
    param ()

    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"
    $valueName = "NoGPOListChanges"
    $valueData = 0

    try {
        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }

        New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value $valueData -Force | Out-Null

        Write-Host "Registry setting configured successfully." -ForegroundColor Green
        Write-Host "Path: $regPath"
        Write-Host "Name: $valueName"
        Write-Host "Value: $valueData"

        Write-Host "`nVerification:" -ForegroundColor Yellow
        Get-ItemProperty -Path $regPath -Name $valueName | Select-Object $valueName
    }
    catch {
        Write-Error "Failed to configure the registry setting. $_"
    }
}

Set-NoGPOListChangesPolicy
