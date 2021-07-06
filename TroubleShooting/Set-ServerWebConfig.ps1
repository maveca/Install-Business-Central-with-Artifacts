# Before starting this script please update Manifest.json
# Expected server instance name is BC.

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Read-Configuration.psm1 -Force
$containerName = Get-ContainerName

$confKey = Read-Host -Prompt "Input the configuration key name"
$confValue = Read-Host -Prompt "Input the configuration key value"

Invoke-ScriptInBcContainer -containerName $containerName -argumentList ($confKey, $confValue) -scriptblock {
    param($confKey, $confValue)
    Set-NAVWebServerInstanceConfiguration -WebServerInstance "BC" -KeyName $confKey -KeyValue $confValue
}

