Import-Module "./Install/Read-Configuration.psm1" -Force
$config = Resolve-Artifact(Get-Configuration)
New-BCContainer @config