#
#
1 关闭win防火墙，或放行端口。

2 支持http://127.0.0.1:2379 或 http://你的内网ip.如.192.168:2379

3 生产级：
应使用3节点etcd，或5节点etcd。
3.1 3节点单云：网关1，网关2，worker1。---最常用的部署。
3.2 3节点2云：云1网关1，云1网关2，云2网关1。风险：云1的2个网关全挂。
3.3 5节点单云：网关1，网关2，worker1，worker2，worker3。
3.4 5节点2云：云1网关1，云1网关2，云2网关1，云2网关2，云2worker1。风险：云1的2个网关，和1个worker全挂。
3.5 最佳方案：3地3节点，或3地5节点。
不应该使用，etcd自动生成证书功能：auto-tls。
支持win，linux节点混用。
3节点，应先删除坏掉的节点，再添加新空【学徒】节点。5坏1时，不需要这么做。

4 本测试级etcd：
单win节点。使用单节点etcd，无https，无认证。
即运行：  “d单机，http，无认证.ps1”


5 etcd 下载地址：
https://github.com/etcd-io/etcd/releases

6win中用powershell建立etcd证书：
此命令属于pki模块，win8及以上win可用，win2012及以上可用。
$etcdca根证书参数 = @{
CertStoreLocation = "Cert:\CurrentUser\My"
KeyAlgorithm = 'RSA'
HashAlgorithm = 'sha256'
KeyLength = 4096 
Type = 'Custom'
KeySpec = 'Signature' 
KeyUsageProperty = 'Sign'
KeyUsage = 'CertSign'
Subject = "CN=kaiiit软件实验室" 
KeyExportPolicy = 'Exportable' 
NotBefore = (get-date).AddYears(-1)
NotAfter = (get-date).AddYears(20)
FriendlyName = 'etcdca根证书2024'
}

$etcdca证书 = New-SelfSignedCertificate @etcdca根证书参数
================================================================================================================
$etcdca证书 = Get-ChildItem -Path 'Cert:\CurrentUser\My' | Where-Object {$_.FriendlyName -eq 'etcdca根证书2024'}
$mypwd = ConvertTo-SecureString -String "password" -Force -AsPlainText
Export-Certificate -Cert $etcdca证书 -FilePath a:\etcd-v3.5-windows-amd64\cert\ca.crt

$etcd客户端证书参数 = @{
CertStoreLocation = "Cert:\CurrentUser\My"
KeyAlgorithm = 'RSA'
HashAlgorithm = 'sha256'
KeyLength = 2048 
KeyExportPolicy = 'Exportable' 
NotBefore = (Get-Date).adddays(-10)
NotAfter = (get-date).AddYears(20)
Signer = $etcdca证书
Subject = "CN=etcd-client" #颁发者。或名字
Type = 'Custom'
KeySpec = 'Signature' 
KeyUsage = 'KeyEncipherment', 'DigitalSignature', 'CertSign'
TextExtension = @("2.5.29.37={text}1.3.6.1.5.5.7.3.1,1.3.6.1.5.5.7.3.2",
"2.5.29.17={text}IPAddress=127.0.0.1&IPAddress=192.168.88.88") #必须输入，这里必须更改为你真实的ip！！！
FriendlyName = '我的etcd客户端证书'
}

New-SelfSignedCertificate @etcd客户端证书参数

# 导出证书
$cert = Get-ChildItem -Path 'Cert:\CurrentUser\My' | Where-Object {$_.FriendlyName -eq '我的etcd客户端证书'}
$mypwd = ConvertTo-SecureString -String "password" -Force -AsPlainText
Export-pfxCertificate -Cert $cert -FilePath c:\ProgramData\k4t\etcd_3.5\cert\server.pfx -Password $mypwd
cd c:\ProgramData\k4t\etcd_3.5\cert\
#说明：为了简化，我把这个key做成了同时支持server认证（即n个etcd节点之间），和client认证（即etcd客户机到etcd）
#你可以用同一个key（复制key文件）放在【n个etcd节点之间】和【etcd客户机】用，也可以生成2个不同的key分别用。
#先自行安装openssl。https://github.com/OpenVPN/easy-rsa/releases
openssl pkcs12 -in server.pfx -out server.crt -clcerts -nokeys
openssl pkcs12 -in server.pfx -out server.key -nocerts -nodes
