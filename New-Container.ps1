$config = (./Install/Read-Configuration.ps1 -resolveCredential -resolveArtifact)

./Install/Update-BCContainerHelper.ps1

./Install/Install-BCContainer.ps1

./Install/Install-Certificate.ps1

./Install/Set-SessionTimeout.ps1

./Install/Invoke-WebClient.ps1

./Install/Write-LaunchJSon.ps1 | Out-File -FilePath ./launch.json -Encoding utf8
Write-Host "Application Version: $(Get-NavContainerNavVersion -containerOrImageName $config.ContainerName)" -ForegroundColor Green
Write-Host "Platform Version   : $(Get-NavContainerPlatformVersion -containerOrImageName $config.ContainerName)" -ForegroundColor Green
