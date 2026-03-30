#
Set-Location ${PSScriptRoot}

$rev = (etcdctl endpoint status --write-out="json" | ConvertFrom-Json)[0].header.revision
etcdctl compact $rev
  
  