#!/bin/bash
# ---------------------------------------------------------------------------
# cattura CTRL+C per uscire
trap '' TERMINT


 
# display message and pause 
pause(){
	local m="$@"
	echo "$m"
	read -p "Premi [Enter] per continuare..." key
}
 
# set an 
while :
do
	# show menu
	clear
	# e[31m colore rosso e grassetto, \e[0m resetta le opzioni
	echo "------------------------------------------------"
	echo -e " \e[31m 	         M A I N - M E N U\e[0m"
	echo "------------------------------------------------"
	echo -e "\e[31m 1. Crea Folder del Progetto\e[0m"
	echo -e "\e[31m 2. Crea Gruppo di Progetto\e[0m"
	echo -e "\e[31m 3. Aggiungi Utente a un Gruppo di Progetto\e[0m"
	echo -e "\e[31m 4. Mostra gli Utenti di un Gruppo di Progetto\e[0m"
	echo -e "\e[31m 5. Exit\e[0m"
	echo "------------------------------------------------"
	read -r -p "Scegli l'opzione [1-5] : " c
	# take action
	REPDIR=/media/RepoHD

	case $c in
		1) echo "------------------------------------------------------------"
		   echo -e " \e[31m Inserisci il Nome della Folder del Progetto (senza spazi)\e[0m"
   		   echo -e " \e[31m CTRL+C per uscire\e[0m"
		   echo "------------------------------------------------------------"
		   echo
		   read namefolder
		   mkdir $REPDIR/$namefolder
		   echo
		   echo "Folder  creata"
		pause;;
		2)echo "-----------------------------------------------"
		  echo -e "\e[31m Inserisci un Nome per il Gruppo di Progetto \e[0m "
   		   echo -e " \e[31m CTRL+C per uscire\e[0m"
		  echo "-----------------------------------------------"
		  read namegroup
		  echo
		  sudo groupadd $namegroup
		  echo "------------------------------------------"
		  echo -e " \e[31m A quale Folder lo applico?\e[0m" 
		  echo "------------------------------------------"
		  ls  $REPDIR
		  echo
		  read namefolder2
		  sudo chgrp $namegroup $REPDIR/$namefolder2
		  echo
		  echo -e "\e[31m Associato gruppo alla Folder\e[0m"
		  echo
		  echo -e "\e[31m Inizializzo Repository GIT BARE\e[0m"
		  cd $REPDIR/$namefolder
		  git --bare init
		  echo
		  pause;;		
		3) 
		  cat /etc/group | cut -d: -f1,5
		  echo
		  echo "------------------------------------------"
		  echo -e "\e[31m Inserisci il Nome di un GruppoProgetto:\e[0m"
   		   echo -e " \e[31m CTRL+C per uscire\e[0m"
		  echo "------------------------------------------"
		  echo
		  read namegroup2
		  echo
		  echo "------------------------------------------"
		  echo -e "\e[31m Quale utente inserire nel gruppo?\e[0m"
		   echo -e " \e[31m CTRL+C per uscire\e[0m"
		  echo "------------------------------------------"
		  echo
		  cat /etc/passwd | grep 1000* | cut -d: -f1 
		  echo  "------------------------------------------"
		  echo
		  read user
		  sudo usermod -a -G $namegroup2 $user
		  pause;;
		4) echo "------------------------------------------"
		   echo -e "\e[31m Inserisci il Nome del Gruppo di Progetto:\e[0m"
		   echo "------------------------------------------"
		   cat /etc/group | cut -d: -f1,5
		   echo
		   echo "------------------------------------------"
		   echo -e "\e[31m Inserisci il Nome del Gruppo di Progetto:\e[0m"
		   echo "------------------------------------------"
		   echo
		   read namegroup 
		   sudo grep  $namegroup /etc/group
		   pause;;
		5) break;;
		*) "Seleziona un'opzione da 1 a 5 "
	esac
done