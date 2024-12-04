#!/bin/bash

# Verifica lo stato attuale del login remoto
current_status=$(sudo -S systemsetup -getremotelogin | awk '{print $3}')

# Se il login remoto è attualmente "off", lo accende
if [ "$current_status" == "Off" ]; then
    sudo -S systemsetup -setremotelogin on
    echo "Il login remoto è stato abilitato."
# Altrimenti, se il login remoto è attualmente "on", lo spegne
else
    confirm=$(echo "yes" | sudo -S systemsetup -setremotelogin off 2>&1)
    # Verifica se la richiesta di conferma è stata visualizzata
    if [[ $confirm =~ "Do you really want to turn remote login off?" ]]; then
        echo "Il login remoto è stato disabilitato."
    else
        echo "Errore durante la disabilitazione del login remoto."
    fi
fi
