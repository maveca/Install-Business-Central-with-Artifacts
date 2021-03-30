If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    if (Get-Module -ListAvailable -Name BcContainerHelper) {
        Write-Host "Checking for BCContainerHelper update..."

        $online = Find-Module -Name bccontainerhelper -Repository PSGallery
        $installed = Get-Module -Name bccontainerhelper -ListAvailable
    
        if ($online[0].Version -eq $installed[0].Version)
        {
            exit
        }
        Write-Host "New version of BCContainerHelper module is available. Updateing BCContainerHelper..."
    } else {
        Write-Host "Installing BCContainerHelper..."
    }

    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs -Wait
    exit
}

# Uninstalling old bccontainerhelper version
if (Get-Module -ListAvailable -Name BcContainerHelper) {
    Update-Module BCContainerHelper -Force
} else {
    Install-Module BcContainerHelper -force
}

Start-Sleep -Seconds 2