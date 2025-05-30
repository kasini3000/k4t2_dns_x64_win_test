#
Set-Location ${PSScriptRoot}

./etcd  --name=tls01 `
  --data-dir=".\db\tls01" `
  --listen-client-urls=https://0.0.0.0:2379,http://127.0.0.1:2379 `
  --advertise-client-urls=https://0.0.0.0:2379 `
  --initial-advertise-peer-urls=https://0.0.0.0:2380 `
  --listen-peer-urls=https://0.0.0.0:2380 `
  --initial-cluster=tls01=https://0.0.0.0:2380,tls02=https://0.0.0.0:2381,tls03=https://0.0.0.0:2382 `
  --initial-cluster-token=etcd-cluster-1 `
  --initial-cluster-state=new `
  --trusted-ca-file=".\cert\ca.crt" `
  --cert-file=".\cert\server.crt" `
  --key-file=".\cert\server.key" `
  --peer-auto-tls=true

#  --cert-file=".\data\tls01\fixtures\client\cert.pem" `
#  --key-file=".\data\tls01\fixtures\client\key.pem" `
#  --peer-cert-file=".\data\tls01\fixtures\peer\cert.pem" `
#  --peer-cert-file=".\data\tls01\fixtures\peer\cert.pem"  