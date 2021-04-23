# Before starting this script please update Manifest.json

Import-Module .\Install\Load-Configuration.psm1 -Force

. (Join-Path $PSScriptRoot "install\Update-BCContainerHelper.ps1")

Write-Host ""
$credential = Invoke-Credential

$containerName = Get-ContainerName
$artifactUrl = Get-ArtifactUrl
$authentication = Get-Authentication
$assignPremiumPlan = Get-AssignPremiumPlan
$licenseFile = Get-LicenseFile

Remove-BCContainer $containerName

# https://github.com/microsoft/navcontainerhelper/blob/master/ContainerHandling/New-NavContainer.ps1

New-BCContainer `
    -accept_eula `
    -containerName $containerName `
    -artifactUrl $artifactUrl `
    -Credential $credential `
    -useSSL `
    -auth $authentication `
    -licenseFile $licenseFile `
    -assignPremiumPlan:$assignPremiumPlan `
    -updateHosts `
    -accept_outdated `
    -includeAL `
    -memoryLimit 10G `
    -isolation hyperv `
    -shortcuts 'None'

. (Join-Path $PSScriptRoot "Install\Install-Certificate.ps1")

Start-Process "https://$containerName/BC/?tenant=default&signInRedirected=1"