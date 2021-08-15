if ($null -eq $config)
{
    $config = (./Install/Read-Configuration.ps1)
}

$serverConfig = @{}
./Troubleshooting/Get-ServerConfig.ps1 | ForEach-Object { $serverConfig[$_.key] = $_.value }


$port = "http"
if ($config.useSSL)
{
    $port = "https"
}

Write-Output @"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "My Docker Container",
            "request": "launch",
            "type": "al",
            "environmentType": "$($serverConfig['TenantEnvironmentType'])",
            "server": "$($serverConfig['PublicWebBaseUrl'])",
            "port": $($serverConfig['DeveloperServicesPort']),
            "serverInstance": "$($serverConfig['ServerInstance'])",
            "authentication": "$($serverConfig['ClientServicesCredentialType'])",
            "breakOnError": true,
            "launchBrowser": false,
            "enableLongRunningSqlStatements": true,
            "enableSqlInformationDebugger": true,
            "tenant": "default"
        }
    ]
}
"@

