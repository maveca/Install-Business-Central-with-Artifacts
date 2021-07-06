# Before starting this script please update Manifest.json

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Read-Configuration.psm1 -Force
$containerName = Get-ContainerName

Invoke-ScriptInBcContainer -containerName $containerName -scriptblock {

    Set-NAVServerConfiguration -ServerInstance "BC" -KeyName "SessionTimeout" -KeyValue "01:00:00"

    Stop-NAVServerInstance -ServerInstance "BC"

    Start-NAVServerInstance -ServerInstance "BC"
}

