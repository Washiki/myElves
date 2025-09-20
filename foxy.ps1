function foxy{
param(
	#type varname value(default)

	#these are dummy values. Replace them with your own. 
	[string]$ip="172.31.2.4:8080",
	[string]$url="https://ironport4.iiita.ac.in/",
	[string]$browser="chrome.exe"
)	
	$pro = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" 
	$cur = (Get-ItemProperty -Path $pro -Name ProxyEnable).ProxyEnable

	if($cur -eq 1) {
		Set-ItemProperty -Path $pro -Name ProxyEnable -Value 0 
		Write-Output "Proxy has been disabled"
	}
	else{
		#within HKEY CURRENT USER, proxyserver and enable are what is being set. 
	
		Set-ItemProperty -Path $pro -Name ProxyServer -Value $ip
		Set-ItemProperty -Path $pro -Name ProxyEnable -Value 1 
		Write-Output "Proxy has been enabled"
		Start-Process $browser $url
	}
	Get-ItemProperty -Path $pro | Select-Object ProxyEnable, ProxyServer, ProxyOverride
}


#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/dhokha.omp.json" | Invoke-Expression

#function kali {wsl -d kali-linux}
#function ub {wsl -d Ubuntu-22.04}

