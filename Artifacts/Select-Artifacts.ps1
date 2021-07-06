Write-Host "Select all 2016 versions"
Get-NAVArtifactUrl -nav 2016 -cu 9 -country w1 -select all

Write-Host "Select all 16 versions"
Get-BCArtifactUrl -type OnPrem -version 16 -country ru -select Latest

