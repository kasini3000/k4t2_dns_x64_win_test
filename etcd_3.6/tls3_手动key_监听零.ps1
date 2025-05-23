#
Set-Location ${PSScriptRoot}

./etcd  --name=tls03 `
  --data-dir=".\db\tls03" `
  --listen-client-urls=https://0.0.0.0:2377,http://127.0.0.1:2377 `
  --advertise-client-urls=https://0.0.0.0:2377 `
  --initial-advertise-peer-urls=https://0.0.0.0:2382 `
  --listen-peer-urls=https://0.0.0.0:2382 `
  --initial-cluster=tls01=https://0.0.0.0:2380,tls02=https://0.0.0.0:2381,tls03=https://0.0.0.0:2382 `
  --initial-cluster-token=etcd-cluster-1 `
  --initial-cluster-state=new `
  --trusted-ca-file=".\cert\ca.crt" `
  --cert-file=".\cert\server.crt" `
  --key-file=".\cert\server.key" `
  --peer-auto-tls=true

#  --cert-file=".\cert\server.crt" `
#  --key-file=".\cert\server.key" `
#  --trusted-ca-file="\cert\ca.crt" `
#  --client-cert-auth=false