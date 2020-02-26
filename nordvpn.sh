#!/bin/bash

function isrunning()
{
    pidof -s "$1" > /dev/null 2>&1
    status=$?
    if [[ "$status" -eq 0 ]]; then
        echo 1
    else
        echo 0
    fi
}


	clear
	echo "LOADING..."
	sleep 1
	clear
	sleep 1
        echo "."
	sleep 1
	clear
	echo ".."
	sleep 1
	clear
	echo "..."
	sleep 1
	clear
	echo "STARTING..."
	sleep 1
	clear
	echo "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"
	echo "––––––––––––––––––-------–  Greco395 NordVPN Client --------––––––----––––––––––"
	echo "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"

	if [[ $(isrunning openvpn) -eq 1 ]]; 
	then 
		red=`tput setaf 1`
		green=`tput setaf 2`
		reset=`tput sgr0`
		echo "${red}STATUS: ${green}running${reset}"
	else
		red=`tput setaf 1`
		green=`tput setaf 2`
		reset=`tput sgr0`
		echo "${red}STATUS: stopped${reset}"
	fi
	
	echo -e "\nSELEZIONARE IL PROTOCOSSO SUL QUALE SI VUOLE LA PROTEZIONE\n1)tcp protection\n2)udp protection\n3)disconnect all\n4)guide\n5)exit\n"
	read type

	if [ $type == 1 ]
	then
		pathToFile="/etc/openvpn/ovpn_tcp"
		protocol="tcp"
		ls /etc/openvpn/ovpn_tcp/
	elif [ $type == 2 ]
	then
		pathToFile="/etc/openvpn/ovpn_udp"
		protocol="udp"
		ls /etc/openvpn/ovpn_udp/
	elif [ $type == 3 ]
	then
		sudo killall openvpn
		sudo killall openvpn
		sudo service openvpn stop
		echo "SERVIZION VPN DISCONNESSO"
		./nordvpn.sh
	elif [ $type == 4 ]
	then
		 clear
		 echo "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"
		 echo "––––––––––––––––––----  Greco395 NordVPN Client Guide  -----––––––----––––––––––"
		 echo "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"
		 
		 red=`tput setaf 1`
		 green=`tput setaf 2`
		 reset=`tput sgr0`
		 echo -e "\n${red}Script by Greco395${reset} ( ${green}greco395.com${reset} )\n"
		 
		 echo -e "-> apt-get install gnome-terminal\n-> sudo apt-get install openvpn\n-> cd /etc/openvpn/\n-> sudo wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip\n-> sudo unzip ovpn.zip\n-> sudo rm ovpn.zip\n\n"
		 echo -e "Se esegui questi comandi questo script funzionerà correttamente.\npremi invio per continuare"
		 read action
		 ./nordvpn.sh
	elif [ $type == 5 ]
	then
		exit 1
        exit 113
        exit
	else
		echo "Selezione non valida"
		exit 1
	fi

	echo -e "\n"
	echo -e "SELEZIONA LO LA VPN ( example: it13 )\n"
	read file_pre
	file="$file_pre.nordvpn.com.$protocol.ovpn"

	if [ $type == 1 ]
	then

		if [ -z "${file}" ]
		then
			selected_file="it13.nordvpn.com.tcp.ovpn"
		else
			selected_file=$file
		fi
		
	elif [ $type == 2 ]
	then

		if [ -z "${file}" ]
		then
			selected_file="it13.nordvpn.com.udp.ovpn"
		else
			selected_file=$file
		fi
		
	fi

	# echo $selected_file
	echo -e "FILE SEZIONATO CORRETTAMENTE\n\navvio in "
	sleep 1
	echo 2
	sleep 1
	echo 1
	sleep 1
	echo AVVIO IN CORSO...
	sleep 1

	gnome-terminal -x sh -c './nordvpn.sh; bash'
	sleep 1
	sudo openvpn --config "$pathToFile/$selected_file" --auth-user-pass "/etc/openvpn/pass.txt"
	echo "reloading..."
	sleep 5
	./nordvpn.sh
