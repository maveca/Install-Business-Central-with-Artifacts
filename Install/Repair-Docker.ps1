If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    exit
}

# Now running elevated so launch the script:
Write-Host "Stopping docker service..."
Stop-Service docker
Write-Host "Starting docker service..."
Start-Service docker
docker system prune
Read-Host "Press ENTER to continue."