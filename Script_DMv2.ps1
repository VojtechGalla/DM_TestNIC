$NICList = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | where{ $_.IPEnabled -eq "1" }
Write-Host "Aktivní interface:" -foregroundcolor red
if ($NICList -ne $null)
{
	echo $NICList | select Index, Description, IPAddress, MacAddress | Format-Table -AutoSize
}
else
{
	Write-Host "Neni připojený kabel / vypnutá síťovka" -foregroundcolor Red -backgroundcolor Black
	Write-Host "`n`Press any key to continue ..."
	#$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	Exit
}

$index = Read-Host "Zadej index interface"
$SelectedNIC = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | where{ $_.Index -eq $index } | select IPAddress, DefaultIPGateway, IPSubnet, DNSServerSearchOrder, MacAddress, DHCPEnabled
Write-Host ($SelectedNic | Format-List | Out-String)