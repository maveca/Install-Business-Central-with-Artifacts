$base = Get-Content -Raw '.\Manifest.json' | ConvertFrom-Json
$config = Get-Content -Raw $base.File | ConvertFrom-Json

function Get-Authentication {
    if ($null -ne $base.Auth) {
        return $base.Auth
    } else {
        return $config.Auth
    }
}
function Invoke-Credential {
    if ($null -ne $base.UserName) {
        return New-Object pscredential $base.UserName, (ConvertTo-SecureString -AsPlainText -Force -String $base.Password)
    } else {
        return Get-Credential -Message "Using $($base.Auth) authentication. Please enter your $($base.Auth) credentials for the host computer."
    }
}

function Get-ContainerName {
    return $config.ContainerName
}

function Get-Version {
    return $config.Version
}

function Get-InsiderToken {
    return $config.InsiderToken
}

function Get-ArtifactUrl {
    if($null -ne $config.StorageAccount)
    {
        return Get-BCArtifactUrl -type $config.Type -country $config.Country -select $config.Select -storageAccount $config.StorageAccount -sasToken $config.SASToken
    }
    else
    {
        return Get-BCArtifactUrl -type $config.Type -country $config.Country -select $config.Select
    }
}

function Get-DNSAddress {
    $dns = Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses
    return $dns[0]
}

function Get-AssignPremiumPlan {
    return ('True' -eq $config.AssignPremiumPlan)
}

function Get-LicenseFile {
    if($null -ne $config.LicenseFile){
        return (Resolve-Path -Path $config.LicenseFile)
    } else {
        return ""
    }
}

function Get-Artifacts {
    return $config.Artifacts
}

Write-Host "Configuration $($base.File) is loaded."