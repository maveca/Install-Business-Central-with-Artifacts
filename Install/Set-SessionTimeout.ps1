# Before starting this script please update Manifest.json
# Expected server instance name is BC.

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Read-Configuration.psm1 -Force
$containerName = Get-ContainerName

Invoke-ScriptInBcContainer -containerName $containerName -scriptblock {
    Set-NAVWebServerInstanceConfiguration -WebServerInstance "BC" -KeyName "SessionTimeout" -KeyValue "12:00:00"
    Write-Host "SessionTimeout is:"
    Get-NAVWebServerInstanceConfiguration -WebServerInstance "BC" -KeyName "SessionTimeout"
}

