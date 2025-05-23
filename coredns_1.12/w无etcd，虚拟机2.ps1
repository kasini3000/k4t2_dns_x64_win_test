#每小时切换dns进程。
#监控频率=30秒。当【w无etcd，虚拟机2.txt】变更时，重启自身。
#生产应该同时运行2个主dns，分别监听台虚拟机上ip的53端口。
Set-Location ${PSScriptRoot}

$pr = Get-Process coredns -ErrorAction SilentlyContinue
if ( ($null -eq $pr) -or ($pr -eq '') )
{
}
else
{
	foreach ($i in $pr)
	{
		Stop-Process -Id $i.id
	}
}
Start-Sleep -Seconds 2

$p = Start-Process -FilePath "c:\ProgramData\k4t\coredns_1.11\coredns.exe"  -WindowStyle "hidden" `
	-ArgumentList " -conf c:\ProgramData\k4t\coredns_1.11\w无etcd，虚拟机2.txt" -PassThru

$f1 = Get-ChildItem -LiteralPath "c:\ProgramData\k4t\coredns_1.11\w无etcd，虚拟机2.txt"
$f1lt = $f1.LastWriteTime

while ($true)
{
	if ($(Get-ChildItem -LiteralPath "c:\ProgramData\k4t\coredns_1.11\w无etcd，虚拟机2.txt").LastWriteTime -gt $f1lt)
	{
		Write-Warning '警告：配置文件已经变化'
		Stop-Process -Id $p.Id
		Start-Sleep -Seconds 2

		Write-Warning '警告：正在启动dns2'
		Start-Process -FilePath  "powershell.exe" -WindowStyle "hidden" `
			-ArgumentList " -file c:\ProgramData\k4t\coredns_1.11\w无etcd，虚拟机2.ps1"
		exit
	}
	Write-Host -NoNewline -ForegroundColor Yellow '.'
	Start-Sleep -Seconds 30

	if ( ((Get-Date) - (Get-Process -Id $pid).StartTime).Hours -gt 1)
	{
		Write-Warning '警告：超过1小时'
		Stop-Process -Id $p.Id
		Start-Sleep -Seconds 2

		Write-Warning '警告：正在启动dns2'
		Start-Process -FilePath  "powershell.exe" -WindowStyle "hidden" `
			-ArgumentList " -file c:\ProgramData\k4t\coredns_1.11\w无etcd，虚拟机2.ps1"
		exit
	}
}
