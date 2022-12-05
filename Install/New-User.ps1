$container = "<Container Name>"
$user = "<Users>"
$pass = "<Password>"

Invoke-ScriptInBcContainer -containerName $container -scriptblock {
    try {
        New-NAVServerUser BC -tenant default -UserName $user -Password (ConvertTo-SecureString $pass -AsPlainText -Force)
        Write-Host "User {$user} has been created." -ForegroundColor Green
    }
    catch {
        Write-Host "User has not been created." -ForegroundColor Red
    }
}
