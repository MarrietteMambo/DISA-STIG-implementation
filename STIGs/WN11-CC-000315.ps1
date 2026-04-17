<#
.SYNOPSIS
    This PowerShell function disables AlwaysInstallElevated by setting it to 0 in HKLM and HKCU, preventing privilege escalation and ensuring secure Windows Installer policy compliance.

.NOTES
    Author          : Marriette Mambo
    LinkedIn        : linkedin.com/in/marriette-mambo/
    GitHub          : github.com/MarrietteMambo
    Date Created    : 04-17-26
    Last Modified   : 04-17-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315
    Documentation   : https://stigaview.com/products/win11/v2r3/WN11-CC-000315/

.TESTED ON
    Date(s) Tested  : 04-17-26
    Tested By       : Marriette Mambo
    Systems Tested  : 
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000315.ps1 
#>

function Set-AlwaysInstallElevatedPolicy {
    [CmdletBinding()]
    param ()

    $paths = @(
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer",
        "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"
    )

    foreach ($path in $paths) {
        # Ensure the registry path exists
        if (-not (Test-Path $path)) {
            New-Item -Path $path -Force | Out-Null
        }

        # Set the AlwaysInstallElevated value to 0 (REG_DWORD)
        Set-ItemProperty -Path $path -Name "AlwaysInstallElevated" -Type DWord -Value 0
    }

    Write-Output "AlwaysInstallElevated policy has been set to 0 for both HKLM and HKCU."
}
