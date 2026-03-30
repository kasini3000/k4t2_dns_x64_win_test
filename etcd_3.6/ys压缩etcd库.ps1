#
Set-Location ${PSScriptRoot}

if ( ($IsWindows -eq $True) -or ($PSVersionTable.psversion.major -lt 6) ) #win
{
  $rev = (./etcdctl endpoint status --write-out="json" | ConvertFrom-Json)[0].Status.header.revision
  ./etcdctl compact $rev
}
else 
{
  $rev = (etcdctl endpoint status --write-out="json" | ConvertFrom-Json)[0].Status.header.revision
  etcdctl compact $rev
}   

  
  