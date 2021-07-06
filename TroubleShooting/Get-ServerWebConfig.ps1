# Before starting this script please update Manifest.json

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Read-Configuration.psm1 -Force
$containerName = Get-ContainerName

$confKey = Read-Host -Prompt "Input the configuration key name"

Invoke-ScriptInBcContainer -containerName $containerName -argumentList $confKey -scriptblock {
    param($confKey)
    Get-NAVWebServerInstanceConfiguration -WebServerInstance "BC" -KeyName $confKey
}

