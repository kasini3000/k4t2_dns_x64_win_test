#
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

$p = Start-Process -FilePath "c:\ProgramData\k4t\coredns_1.12\coredns.exe"  -WindowStyle "hidden" `
	-ArgumentList " -conf c:\ProgramData\k4t\coredns_1.12\y有etcd，虚拟机1.txt" -PassThru

$f1 = Get-ChildItem -LiteralPath "c:\ProgramData\k4t\coredns_1.12\y有etcd，虚拟机1.txt"
$f1lt = $f1.LastWriteTime

while ($true)
{
	if ($(Get-ChildItem -LiteralPath "c:\ProgramData\k4t\coredns_1.12\y有etcd，虚拟机1.txt").LastWriteTime -gt $f1lt)
	{
		Write-Warning '警告：配置文件已经变化'
		Stop-Process -Id $p.Id
		Start-Sleep -Seconds 2

		Write-Warning '警告：正在启动dns1'
		Start-Process -FilePath  "powershell.exe" -WindowStyle "hidden" `
			-ArgumentList " -file c:\ProgramData\k4t\coredns_1.12\y有etcd，虚拟机1.ps1"
		exit
	}
	Write-Host -NoNewline -ForegroundColor Yellow '.'
	Start-Sleep -Seconds 30

	if ( ((Get-Date) - (Get-Process -Id $pid).StartTime).Hours -gt 1)
	{
		Write-Warning '警告：超过1小时'
		Stop-Process -Id $p.Id
		Start-Sleep -Seconds 2

		Write-Warning '警告：正在启动dns1'
		Start-Process -FilePath  "powershell.exe" -WindowStyle "hidden" `
			-ArgumentList " -file c:\ProgramData\k4t\coredns_1.12\y有etcd，虚拟机1.ps1"
		exit
	}
}

Write-Warning '警告：coredns依然在运行'