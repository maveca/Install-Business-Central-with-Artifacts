$fileName = "C:\Users\Aleksander.Mavec\Documents\AL\ALProject23\BEterna_ALProject23_3.0.0.4.app"
Copy-FileToNavContainer -containerName Insider -localPath $fileName -containerPath c:\run\myapp.app

Invoke-ScriptInNavContainer -containerName Insider -scriptblock {
  Publish-NAVApp -ServerInstance BC -Path c:\run\myapp.app -SkipVerification
  Sync-NAVApp -ServerInstance BC -Name ALProject23
  Start-NAVAppDataUpgrade -ServerInstance BC -Name ALProject23 -Force
}

Invoke-ScriptInNavContainer -containerName Insider -scriptblock {
  Get-EventLog Application -EntryType Error -Newest 1 | % {$_.Message}
}
