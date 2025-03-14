#!/bin/bash

# Chemins des dossiers des VM
SERVER_DIR="server"
CLIENT_DIR="client"

# Fonction pour démarrer les VMs avec VirtualBox
start_vms() {
    echo "Démarrage des machines avec VirtualBox..."
    (cd $SERVER_DIR && vagrant up --provider=virtualbox)
    (cd $CLIENT_DIR && vagrant up --provider=virtualbox)
    echo "Les machines sont prêtes !"
}

# Fonction pour arrêter les VMs
stop_vms() {
    echo "Arrêt des machines..."
    (cd $SERVER_DIR && vagrant halt)
    (cd $CLIENT_DIR && vagrant halt)
    echo "Machines arrêtées."
}

# Fonction pour tester la connectivité réseau et le serveur web
test_connectivity() {
    echo "Test de connexion entre les machines..."
    (cd $CLIENT_DIR && vagrant ssh -c "ping -c 4 192.168.56.10")
    
    echo "Test de l'en-tête HTTP du serveur web..."
    (cd $CLIENT_DIR && vagrant ssh -c "curl -I 192.168.56.10")
    
    echo "Test du contenu de la page web..."
    (cd $CLIENT_DIR && vagrant ssh -c "curl -s 192.168.56.10")
}

# Fonction pour accéder aux VM en SSH
ssh_server() {
    (cd $SERVER_DIR && vagrant ssh)
}

ssh_client() {
    (cd $CLIENT_DIR && vagrant ssh)
}

# Menu interactif
while true; do
    clear
    echo "### Menu de gestion des VM ###"
    echo "1) Démarrer les VM (VirtualBox)"
    echo "2) Accéder au serveur (SSH)"
    echo "3) Accéder au client (SSH)"
    echo "4) Tester la connexion et le serveur web"
    echo "5) Arrêter les VM"
    echo "6) Quitter"
    read -p "Choisissez une option : " choice

    case $choice in
        1) start_vms ;;
        2) ssh_server ;;
        3) ssh_client ;;
        4) test_connectivity ;;
        5) stop_vms ;;
        6) exit 0 ;;
        *) echo "Option invalide, réessayez." ;;
    esac

    read -p "Appuyez sur Entrée pour continuer..."
done

