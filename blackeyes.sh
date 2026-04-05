#!/bin/bash

echo "░▒▓███████▓▒░░▒▓█▓▒░       ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░░▒▓███████▓▒░"
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░"
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░"
echo "░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░▒▓█▓▒░      ░▒▓███████▓▒░░▒▓██████▓▒░  ░▒▓██████▓▒░░▒▓██████▓▒░  ░▒▓██████▓▒░"
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░             ░▒▓█▓▒░"
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░             ░▒▓█▓▒░"
echo "░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓███████▓▒░"
echo ""

#creation d'un dossier
function_create() {
    mkdir ./temphtb
    echo "Repository created"
    mainmenu
}

# function nmap scanner
nmap_function() {
#verification que le package nmap est installé ou non
    if dpkg -s nmap >/dev/null 2>&1; then
        echo "nmap est installé"
    else
        echo "nmap n'est pas installé"
        sudo apt install -y nmap
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
    mainmenu
}

#function ncat
function_ncatlisten() {
    #Verifcation que le package nmap soit installer
    if command -v ncat >/dev/null 2>&1; then
        echo "ncat est installé"
    else
        echo "ncat n'est pas installé"
        sudo apt update && sudo apt install -y ncat
    fi
    read -p "Quelle port souhaiter vous écouter : " portselect
    sudo ncat -lvnp "$portselect"
}

#main menu function
mainmenu() {
    echo "(0) => créer un dossier temp"
    echo "(1) => nmap scanner"
    echo "(2) => ncat listen"
    read -p "choix du module : " choicefirst
    if [ $choicefirst == 0 ];
        then 
            echo " "
            function_create
            echo 
                
    fi
    if [ $choicefirst == 1 ];
        then 
            echo " "
            nmap_function
    fi

    if [ $choicefirst == 2 ];
        then
            echo " "
            function_ncatlisten
    fi
}

mainmenu
