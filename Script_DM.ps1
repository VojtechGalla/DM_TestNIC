$NICList = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | where{ $_.IPEnabled -eq "1"}
Write-Host "Aktivní intenface:" -foregroundcolor red
echo $NICList | select Description, IPAddress, MacAddress, Index
$index = Read-Host "Zadej index interface"
$SelectedNIC = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | where{ $_.Index -eq $index} | select IPAddress, DefaultIPGateway, IPSubnet, DNSServerSearchOrder, MacAddress, DHCPEnabled
Write-Host ($SelectedNic | Format-List| Out-String)

$ping1 = Get-WmiObject -Class Win32_PingStatus -Filter 'Address="172.16.1.1"' | select Address, ResponseTime
$ping2 = Get-WmiObject -Class Win32_PingStatus -Filter 'Address="8.8.8.8"' | select Address, ResponseTime
$ping3 = Get-WmiObject -Class Win32_PingStatus -Filter 'Address="google.com"' | select Address, ResponseTime
$ping4 = Get-WmiObject -Class Win32_PingStatus -Filter 'Address="portal.spseplzen.cz"' | select Address, ResponseTime

Write-Host "Odezvy:" -foregroundcolor red

if($ping1.ResponseTime -lt 0){
	Write-Host $ping1.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host "FAIL"
}else{
	Write-Host $ping1.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host $ping1.ResponseTime -NoNewline; Write-Host " ms"
}

if($ping2.ResponseTime -lt 0){
	Write-Host $ping2.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host "FAIL"
}else{
	Write-Host $ping2.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host $ping2.ResponseTime -NoNewline; Write-Host " ms"
}
if($ping3.ResponseTime -lt 0){
	Write-Host $ping3.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host "FAIL"
}else{
	Write-Host $ping3.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host $ping3.ResponseTime -NoNewline; Write-Host " ms"
}
if($ping4.ResponseTime -lt 0){
	Write-Host $ping4.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host "FAIL"
}else{
	Write-Host $ping4.Address -NoNewline; Write-Host "   " -NoNewline; Write-Host $ping4.ResponseTime -NoNewline; Write-Host " ms"
}

$storageDir = $pwd
$webclient = New-Object System.Net.WebClient
$url = "https://seznam.cz/"
$url1 = "http://idnes.cz"
$file = "$storageDir\test.html"
try
{
	$webclient.DownloadFile($url, $file)
	$size = (Get-Item $file).length
	Write-Host "https: " -NoNewline; Write-Host TRUE
	Remove-Item $file
}
catch { Write-Host "https: " -NoNewline; Write-Host FALSE }

try
{
	$webclient.DownloadFile($url, $file)
	$size = (Get-Item $file).length
	Write-Host "http: " -NoNewline; Write-Host TRUE
	Remove-Item $file
}
catch { Write-Host "http: " -NoNewline; Write-Host FALSE }


Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
