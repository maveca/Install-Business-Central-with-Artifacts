$containerConfig = @{
    containerName = "Sandbox";
    accept_eula = $true;
    updateHosts = $true;
    useSSL = $true;
    #installCertificateOnHost = $true;
    includeAL = $true;
    shortcuts = "None";
    credential = (Get-Credential -credential $env:USERNAME);
    artifactUrl = (Get-BCArtifactUrl -type "Sandbox" -country "base" -select "Latest");
    licenseFile = (Get-LicenseFile)
}

# https://github.com/microsoft/navcontainerhelper/blob/master/ContainerHandling/New-NavContainer.ps1
New-BcContainer @containerConfig

. (Join-Path $PSScriptRoot "Install\Install-Certificate.ps1")

Start-Process "https://$($containerConfig.containerName)/BC/?tenant=default"