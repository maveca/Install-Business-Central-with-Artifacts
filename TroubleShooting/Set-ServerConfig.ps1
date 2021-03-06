# Before starting this script please update Manifest.json
# Expected server instance name is BC.

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Read-Configuration.psm1 -Force
$containerName = Get-ContainerName

Invoke-ScriptInBcContainer -containerName $containerName -scriptblock {

    $confKey = Read-Host -Prompt 'Input the configuration key name'
    $confValue = Read-Host -Prompt 'Input the value for the key'

    Set-NAVServerConfiguration -ServerInstance "BC" -KeyName $confKey -KeyValue $confValue

}

