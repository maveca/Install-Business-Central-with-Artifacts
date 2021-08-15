If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    exit
}

# Now running elevated so launch the script:
Write-Host "Stopping docker service..."

# First force stop desktop version of docker
$process = Get-Process -Name "Docker*"
foreach ($p in $process){
    Stop-Process -Id $p.Id -Force
}

Second force stop Hyper-V
$process = Get-Process -Name "vm*"
foreach ($p in $process){
    Stop-Process -Id $p.Id -Force
}


# Then stop the service itself
$services = Get-Service -Name "*Docker*"
foreach ($s in $services){
    if ($s.Status -eq "Running"){
        Stop-Service -Name $s.Name -Force
    }
}

Write-Host "Starting docker desktop..."
Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"

Check-BcContainerHelperPermissions -Fix
