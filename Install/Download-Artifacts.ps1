Set-Location (get-item $MyInvocation.MyCommand.Path).Directory.Parent.FullName
$loc = Get-Location
Import-Module ".\Install\Load-Configuration.psm1" -Force
$artifacts = Get-Artifacts
$index = 0
$apps = $()

Get-ChildItem .\Download\*.app | foreach { Remove-Item -Path $_.FullName }

foreach ($artifact in $artifacts) {
    $index += 1
    Write-Host "Downloading $artifact to '.\Download\App$index.app'"
    $appPath = Join-Path $loc.Path "Download\App$index.app"
    Invoke-WebRequest -Uri $artifact -OutFile $appPath
    $apps += @($appPath)
} 

Sort-AppFilesByDependencies $apps

$apps

C:\Users\Aleksander.Mavec\Projects\Business Central\Install Business Central with Artifacts\Download\App1.app 
C:\Users\Aleksander.Mavec\Projects\Business Central\Install Business Central with Artifacts\Download\App1.app