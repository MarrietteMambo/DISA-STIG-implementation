<#
.SYNOPSIS
  This script enforces RDP authentication by setting fPromptForPassword to 1, requiring users to enter credentials before establishing a remote session.
    
.NOTES
    Author          : Marriette Mambo
    LinkedIn        : linkedin.com/in/marriette-mambo/
    GitHub          : github.com/MarrietteMambo
    Date Created    : 04-19-26
    Last Modified   : 04-19-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000280
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-CC-000280/

.TESTED ON
    Date(s) Tested  : 04-19-26
    Tested By       : Marriette Mambo
    Systems Tested  : 
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000280.ps1 
#>


function Set-PromptForPasswordRDP {
    [CmdletBinding()]
    param ()

    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
    $valueName = "fPromptForPassword"
    $valueData = 1

    try {
        Write-Host "Configuring RDP prompt for password policy..." -ForegroundColor Cyan

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
        Write-Error "Failed to configure fPromptForPassword policy. $_"
    }
}

# Execute the function
Set-PromptForPasswordRDP
