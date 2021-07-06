If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs -Wait
    exit
}

try {
    # Now running elevated so launch the script:
    Set-Location (Split-Path (get-item $PSScriptRoot) -Parent);
    Import-Module "./Install/Read-Configuration.psm1" -Force
    $containerName = Get-ContainerName

    $certUrl = "http://$($containerName):8080/certificate.cer"
    $tmp = New-TemporaryFile
    $certFile = $tmp.FullName + "cert.cer"
    Invoke-WebRequest -Uri $certUrl -OutFile $certFile
    Import-Certificate -FilePath $certFile -CertStoreLocation Cert:\LocalMachine\Root
    Remove-Item $tmp.FullName -Force
    Remove-Item $certFile -Force

    Write-Host ""
    Write-Host -ForegroundColor Green "Certificate for $containerName successfully imported onto host computer."
    Start-Sleep -Seconds 2
} catch {
    Write-Host -ForegroundColor Red "Unable to download license."
    Start-Sleep -Seconds 20
}
