#!/bin/bash

#verification que le package nmap est installé ou non
if dpkg -s nmap >/dev/null 2>&1; then
    echo "nmap est installé"
else
    echo "nmap n'est pas installé"
    sudo apt install nmap
fi

read -p "Quelles ip souhaiter vous scanner : " ipcible

#option pour le -p-
read -p "Voulez vous scanner tout les ports : [y/n]" poption 

#option -Pn
read -p "Voulez vous scanner les ports de force : [y/n]" forced

#option sV
read -p "Voulez vous que nmap recherche les versions des services installé : [y/n]" services

#aggresivité
read -p "Thread (Entre 0 et 5): " thread

if [ $poption=="y" ] && [ $forced=="y" ] && [ $services=="y" ]
    then
        nmap -p- -Pn -sV -T$thread  $ipcible
elif [ $poption=="y" ] && [ $forced=="y" ] && [ $services=="n" ]
    then
        nmap -p- -Pn -T$thread  $ipcible
elif [ $poption=="y" ] && [ $forced=="n" ] && [ $services=="y" ]
    then
        nmap -p- -sV -T$thread  $ipcible
elif [ $poption=="n" ] && [ $forced=="y" ] && [ $services=="y" ]
    then
        nmap -Pn -sV -T$thread  $ipcible
elif [ $poption=="y" ] && [ $forced=="n" ] && [ $services=="n" ]
    then
        nmap -p- -T$thread  $ipcible
elif [ $poption=="n" ] && [ $forced=="n" ] && [ $services=="y" ]
    then
        nmap -sV -T$thread  $ipcible
elif [ $poption=="n" ] && [ $forced=="n" ] && [ $services=="n" ]
    then
        nmap -T$thread  $ipcible
fi