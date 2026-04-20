<#
.SYNOPSIS
  This script sets fBlockNonDomain to 1 to block Windows from automatically connecting to non-domain networks.
    
.NOTES
    Author          : Marriette Mambo
    LinkedIn        : linkedin.com/in/marriette-mambo/
    GitHub          : github.com/MarrietteMambo
    Date Created    : 04-19-26
    Last Modified   : 04-19-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000060
    Documentation   : https://stigaview.com/products/win11/v2r2/WN11-CC-000060/

.TESTED ON
    Date(s) Tested  : 04-19-26
    Tested By       : Marriette Mambo
    Systems Tested  : 
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000060.ps1 
#>


function Set-BlockNonDomainPolicy {
    [CmdletBinding()]
    param ()

    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"
    $valueName = "fBlockNonDomain"
    $valueData = 1

    try {
        Write-Host "Configuring fBlockNonDomain policy..." -ForegroundColor Cyan

        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }

        New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value $valueData -Force | Out-Null

        Write-Host "Configuration complete." -ForegroundColor Green
        Write-Host "`nVerification:" -ForegroundColor Yellow
        Get-ItemProperty -Path $regPath -Name $valueName | Select-Object $valueName
    }
    catch {
        Write-Error "Failed to configure fBlockNonDomain policy. $_"
    }
}

Set-BlockNonDomainPolicy
