<#
.SYNOPSIS
  This script enables Success auditing for Other Logon/Logoff Events and verifies the setting to support Windows audit policy compliance.
    
.NOTES
    Author          : Marriette Mambo
    LinkedIn        : linkedin.com/in/marriette-mambo/
    GitHub          : github.com/MarrietteMambo
    Date Created    : 04-19-26
    Last Modified   : 04-19-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000560
    Documentation   : https://stigaview.com/products/win11/v1r5/WN11-AU-000560/

.TESTED ON
    Date(s) Tested  : 04-19-26
    Tested By       : Marriette Mambo
    Systems Tested  : 
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000560.ps1 
#>

function Set-OtherLogonLogoffEventsAudit {
    [CmdletBinding()]
    param ()

    try {
        Write-Host "Enabling Success auditing for Other Logon/Logoff Events..." -ForegroundColor Cyan
        auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable | Out-Null

        Write-Host "Configuration complete." -ForegroundColor Green
        Write-Host "`nVerification:" -ForegroundColor Yellow
        auditpol /get /subcategory:"Other Logon/Logoff Events"
    }
    catch {
        Write-Error "Failed to configure audit policy. $_"
    }
}

Set-OtherLogonLogoffEventsAudit
