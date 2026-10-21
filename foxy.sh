#!/bin/bash

host="172.31.2.4"
port="8080"
name="iit2024052"
pass="HoneyRaju%40678"
URL="https://${host}:${port}"
#because profile.d has write protection, cna't pipe directly to it
#tee however runs at root level, so we can use its plumbing to do it 
#multiline doesn't exit, but heredoc does. works with <<DELIM DELIM

#nvm, found a better workaround for apt. Just use -E, i.e sudo -E apt . Preserves environment vars even with sudo. Scary but sure. 

#Also, sourcing is important. Generlaly stuff execute in subshells. To change the values for the current shell, we have to use source.

while getopts "h" flag; do
	case "$flag" in 
		h)
			echo "Proxy toggle for debian"
			echo ""
			echo "Usage:"
			echo "source ./foxy.sh"
			exit ;;
	esac
done		

#spotify can overwrite its own proxy if the session is running 
pkill -x spotify

SPFY_PREF="$HOME/.config/spotify/prefs"


if [ -z "$http_proxy" ]; then 
	export HTTPS_PROXY=$URL
	export FTP_PROXY=$URL
	export HTTP_PROXY=$URL
	export NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com"


	export http_proxy=$URL
	export ftp_proxy=$URL
	export http_proxy=$URL
	export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

	# the gui stuff relies on the DE's proxy. 
	gsettings set org.gnome.system.proxy mode 'manual'
	gsettings set org.gnome.system.proxy.http host "${host}"
	gsettings set org.gnome.system.proxy.http port ${port}
	gsettings set org.gnome.system.proxy.ftp host "${host}"
	gsettings set org.gnome.system.proxy.ftp port ${port}
	gsettings set org.gnome.system.proxy.https host "${host}"
	gsettings set org.gnome.system.proxy.https port ${port}

	# setting up for git
	git config --global http.sslVersion tlsv1.2
	git config --global http.proxy http://${name}:${pass}@${host}:${port}
	git config --global https.proxy http://${name}:${pass}@${host}:${port}

	
	git config --global http.proxyAuthMethod 'anyauth'

	# setting up for spotify
	if [ -f "$SPFY_PREF" ]; then 
		if grep -q "network.proxy.mode=" "$SPFY_PREF"; then 
			sed -i 's/network.proxy.mode=.*/network.proxy.mode=2/' "$SPFY_PREF"
		else 
			echo "network.proxy.mode=2" >> "$SPFY_PREF"
	
		fi
	fi
	echo "Proxy enabled."
else
	unset http_proxy
	unset ftp_proxy 
	unset https_proxy 
	unset no_proxy

	unset HTTP_PROXY 
	unset FTP_PROXY 
	unset HTTPS_PROXY
	unset NO_PROXY
	#ignores setvars and just goes for direct connect
	gsettings set org.gnome.system.proxy mode 'none'
	
	git config --global --unset http.proxy
	git config --global --unset https.proxy
	
	if [ -f "$SPFY_PREF" ]; then
		if grep -q "network.proxy.mode=" "$SPFY_PREF"; then
			sed -i 's/network.proxy.mode=.*/network.proxy.mode=1/' "$SPFY_PREF"
		else
			echo "network.proxy.mode=1" >> "$SPFY_PREF"
		fi
	fi
	
	echo "Proxy disabled"

fi 

