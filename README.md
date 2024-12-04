# Toggle SSH on macOS

This repository contains a simple Bash script that allows you to toggle the **SSH service (Remote Login)** on macOS. Instead of navigating through **System Preferences**, you can quickly enable or disable

- Checks the current status of SSH (enabled or disabled via Remote Login settings).
- Toggles the SSH service:
  - If it's off, the script enables it.
  - If it's on, the script disables it.
- Provides user-friendly feedback on the current state.
- Includes error handling for potential issues.

---

## Script Overview

### Code

```bash
#!/bin/bash

# Verifica lo stato attuale del login remoto (SSH)
current_status=$(sudo -S systemsetup -getremotelogin | awk '{print $3}')

# Se il login remoto è attualmente "off", lo accende
if [ "$current_status" == "Off" ]; then
    sudo -S systemsetup -setremotelogin on
    echo "SSH è stato abilitato."
# Altrimenti, se il login remoto è attualmente "on", lo spegne
else
    confirm=$(echo "yes" | sudo -S systemsetup -setremotelogin off 2>&1)
    # Verifica se la richiesta di conferma è stata visualizzata
    if [[ $confirm =~ "Do you really want to turn remote login off?" ]]; then
        echo "SSH è stato disabilitato."
    else
        echo "Errore durante la disabilitazione di SSH."
    fi
fi
```

## Usage


Rendi eseguibile lo script con `chmod +x togglessh.sh` e aggiungi un alias al tuo file di configurazione della shell (ad esempio, `.bashrc` o `.zshrc`) con `alias togglessh='/path/to/togglessh.sh'`. Ricarica la configurazione della shell con `source ~/.bashrc` o `source ~/.zshrc`.
