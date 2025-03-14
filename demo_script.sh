#!/bin/bash

# Aller dans le dossier du serveur et démarrer la VM
cd server/
vagrant up

# Aller dans le dossier du client et démarrer la VM
cd ../client/
vagrant up

# Attendre quelques secondes pour s'assurer que les machines sont prêtes
sleep 10

# Tester la connectivité entre les machines
echo "Test de connectivité : ping du client vers le serveur"
vagrant ssh -c "ping -c 4 192.168.56.10" client

# Tester l'accès à la page web du serveur
echo "Test de l'accès web : curl depuis le client vers le serveur"
vagrant ssh -c "curl -I http://192.168.56.10" client

# Tester le firewall (exemple : bloquer le ping sur le serveur)
echo "Ajout d'une règle firewall sur le serveur : blocage ICMP"
vagrant ssh -c "sudo ufw deny icmp" server

# Vérifier que le ping ne passe plus
echo "Vérification du blocage du ping"
vagrant ssh -c "ping -c 4 192.168.56.10" client || echo "Ping bloqué avec succès"

# Nettoyage : réactiver le ping
echo "Réactivation du ping"
vagrant ssh -c "sudo ufw allow icmp" server
