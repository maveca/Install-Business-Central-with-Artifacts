# ConvertTo-Hashtable converts json object hashtable.
# Source: https://4sysops.com/archives/convert-json-to-a-powershell-hash-table/
# We can then call this function via pipeline:
# $json | ConvertFrom-Json | ConvertTo-HashTable
function ConvertTo-Hashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )

    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }

        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )

            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject]) {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        }
        else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}

# Merge-Hashtables merges two hashtables together.
# Source: https://stackoverflow.com/questions/8800375/merging-hashtables-in-powershell-how/32890418
# For this cmdlet you can use several syntaxes and you are not limited to two input tables: Using the pipeline: $h1, $h2, $h3 | Merge-Hashtables
# Using arguments: Merge-Hashtables $h1 $h2 $h3
# Or a combination: $h1 | Merge-Hashtables $h2 $h3
Function Merge-Hashtables {
    $Output = @{}
    ForEach ($Hashtable in ($Input + $Args)) {
        If ($Hashtable -is [Hashtable]) {
            ForEach ($Key in $Hashtable.Keys) {$Output.$Key = $Hashtable.$Key}
        }
    }
    $Output
}

function Get-DefaultConfiguration {
    [CmdletBinding()]
    [OutputType('hashtable')]

    $containerConfig = @{
        ContainerName            = "Sandbox";
        accept_eula              = $true;
        updateHosts              = $true;
        useSSL                   = $true;
        includeAL                = $true;
        shortcuts                = "None";
        isolation                = "hyperv";
    }
    Write-Output -NoEnumerate $containerConfig
}
function Add-DefaultConfiguration {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )

    process {
        $containerConfig = Merge-Hashtables $(Get-DefaultConfiguration) $InputObject
        Write-Output -NoEnumerate $containerConfig
    }
}

function Read-Json {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $PathToJson
    )
    $config = Get-Content -Raw $PathToJson | ConvertFrom-Json | ConvertTo-HashTable
    Write-Output $config
}

function Resolve-Artifact {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $config
    )
    $config += @{artifactUrl=(Get-BCArtifactUrl -type $config.Type -country $config.Country -select $config.Select)}
    Write-Output $config
}
