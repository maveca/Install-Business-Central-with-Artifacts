Import-Module "./Install/Read-Configuration.psm1" -Force
$config = Get-Configuration
Start-Process "https://$($config.containerName)/BC/?tenant=default"