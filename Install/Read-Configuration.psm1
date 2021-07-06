$config = $null;
function Get-CurrentDirectory {
    if ($psISE) {
        $CurrentDirectory = Split-Path -Path $psISE.CurrentFile.FullPath
    }
    else {
        if ($profile -match "VScode") {
            $CurrentDirectory = split-path $psEditor.GetEditorContext().CurrentFile.Path
        }
        else {
            $CurrentDirectory = $PSScriptRoot
        }
    }
    Write-Output $CurrentDirectory
}

function Read-Configuration {
    [CmdletBinding()]
    [OutputType('hashtable')]

    param (
        [Parameter(ValueFromPipeline)]
        $config,
        [Parameter(Mandatory=$false)]
        [Switch]$resolveArtifact
    )

    Import-Module (Join-Path (Get-CurrentDirectory) "./Install/Read-Json.psm1") -Force

    if ($null -eq $config)
    {
        $default = Get-DefaultConfiguration
        $manifest = Read-Json('.\Manifest.json')
        $config = Read-Json($manifest.ConfigurationFile)
        $config = Merge-Hashtables $default $manifest $config
    }

    if (($null -eq $config.artifactUrl) -and ($resolveArtifact))
    {
        Write-Host "Resolving Business Central artifact url..."
        Resolve-Artifact -config $config
    }

    Write-Output $config
}

function Get-Configuration {
    return $config
}
function Get-ContainerName {
    return $config.ContainerName
}

$config = Read-Configuration