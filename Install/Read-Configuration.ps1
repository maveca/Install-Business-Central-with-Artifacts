[CmdletBinding()]
param (
    [Parameter()][switch]$resolveCredential,
    [Parameter()][switch]$resolveArtifact
)
Import-Module "./Install/Read-Configuration.psm1" -Force
$config = Read-Configuration
if ($resolveCredential)
{
    Write-Host "Resolving credential..." -ForegroundColor Green
    $config += @{Credential = (Get-Credential -credential $env:USERNAME)}
}
if ($resolveArtifact)
{
    Write-Host "Resolving artifact..." -ForegroundColor Green
    $config += @{artifactUrl = (Get-BCArtifactUrl -type $config.Type -country $config.Country -select $config.Select)}
}
Write-Output -NoEnumerate $config