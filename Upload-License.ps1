$containerName = "Insider"
$licenseFileName = ".\Licenses\License.flf"

Copy-FileToNavContainer -containerName $containerName -localPath $licenseFileName -containerPath c:\run\license.flf

Invoke-ScriptInNavContainer -containerName $containerName -scriptblock {
  Import-NAVServerLicense BC -LicenseData ([Byte[]]$(Get-Content -Path "c:\run\license.flf" -Encoding Byte))
  Start-NAVServerInstance -ServerInstance BC
}