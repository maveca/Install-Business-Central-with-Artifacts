$container = "bcserver"
$credential = (Get-Credential)

New-BcContainerBcUser -containerName $container -credential $credential -fullName $credential.UserName
