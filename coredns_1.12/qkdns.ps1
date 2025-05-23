#建议保存编码为：bom头 + utf8
param(
    [Parameter(Mandatory = $true)]
    [string]$Domain,

    [string]$dnsserver = '127.0.0.1'

)

try
{
    # 创建 IdnMapping 实例
    $idn = [System.Globalization.IdnMapping]::new()

    # 将 Unicode 域名转换为 IDNA (Punycode)
    $asciiDomain = $idn.GetAscii($Domain)

    # 输出结果
    Write-Warning "query【$asciiDomain】from $dnsserver"
    Resolve-DnsName -Name $asciiDomain -Server $dnsserver


}
catch
{
    Write-Error "转换失败: $_"
    exit 1
}


