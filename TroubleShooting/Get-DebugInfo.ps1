# Before starting this script please update Manifest.json

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Load-Configuration.psm1 -Force
$containerName = Get-ContainerName

Get-BcContainerDebugInfo -containerName $containerName
