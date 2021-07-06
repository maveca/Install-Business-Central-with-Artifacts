# Before starting this script please update Manifest.json

Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
Import-Module .\Install\Read-Configuration.psm1 -Force
$containerName = Get-ContainerName

$appFiles = Get-ChildItem .\Download\App\*.app | Foreach-Object {$_.FullName}

Sort-AppFilesByDependencies -appFiles $appFiles

$appFiles