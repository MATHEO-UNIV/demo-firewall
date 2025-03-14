# Projet : Déploiement sécurisé d'un serveur avec firewall et Nginx

## Sommaire
1. [Introduction](#introduction)
2. [Prérequis](#prérequis)
3. [Installation et Lancement](#installation-et-lancement)
4. [Structure du Projet](#structure-du-projet)
5. [Choix Techniques](#choix-techniques)
6. [Configuration du Serveur](#configuration-du-serveur)
7. [Configuration du Client](#configuration-du-client)
8. [Démonstration du Fonctionnement](#démonstration-du-fonctionnement)
9. [Tests de Sécurité et Firewall](#tests-de-sécurité-et-firewall)
10. [Difficultés Rencontrées](#difficultés-rencontrées)
11. [Améliorations Possibles](#améliorations-possibles)
12. [Conclusion](#conclusion)

## 1. Introduction
Ce projet met en place un serveur Debian sécurisé avec un firewall UFW et un serveur web Nginx. Un client Debian est également déployé pour tester la connectivité et la sécurité du serveur via un script d'automatisation.

L'objectif est de démontrer la mise en place d'un environnement sécurisé avec :
- Un serveur web accessible uniquement sur HTTP/HTTPS
- Un firewall bloquant les connexions non autorisées
- Une configuration sécurisée de Nginx
- Des tests de connectivité et de sécurité via un script de démonstration

## 2. Lancement du projet
### Prérequis
- **VirtualBox** installé
- **Vagrant** installé
- **Nmap** installé (pour les tests de sécurité)

### Déploiement des machines
Pour lancer les machines et effectuer les tests, exécutez :
```bash
chmod +x demo_script.sh
./demo_script.sh
```

### Fonctionnalités du script `demo_script.sh`
Le script propose plusieurs options interactives :
1. **Lancer les machines** (`vagrant up`)
2. **Tester la connexion entre le client et le serveur** (ping, curl)
3. **Vérifier les règles du firewall avec `nmap`**
4. **Arrêter les machines** (`vagrant halt`)
5. **Se connecter en SSH** aux machines (`vagrant ssh`)

## 3. Explication des choix techniques
### **Infrastructure**
- **Deux VM Debian** : Un serveur (`server.local`) et un client (`client.local`)
- **IP fixes** :
  - `192.168.56.10` pour le serveur
  - `192.168.56.11` pour le client
- **Communication privée** : Réseau en `private_network`

### **Sécurité**
- **Firewall UFW** :
  - Interdiction de tout trafic entrant par défaut
  - Autorisation uniquement de HTTP (80), HTTPS (443) et SSH (22) depuis le client
  - Protection contre le bruteforce SSH avec `ufw limit ssh`
- **Nginx sécurisé** :
  - Suppression des informations sensibles (`server_tokens off`)
  - Désactivation des méthodes HTTP inutiles
  - Ajout de protections contre les attaques XSS et clickjacking
  - Désactivation des vieux protocoles SSL/TLS

## 4. Résultats et démonstration
Une fois le script exécuté, les résultats attendus sont :
- **Connexion réussie** entre le client et le serveur (ping)
- **Accès réussi à la page web du serveur** (`curl http://192.168.56.10`)
- **Firewall fonctionnel** :
  - Nmap montre uniquement les ports 22, 80 et 443 ouverts
  - Une tentative de connexion SSH depuis une autre IP échoue

Exemple de sortie de `nmap` :
```
Nmap scan report for 192.168.56.10
Host is up (0.00028s latency).
Not shown: 65533 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
```

## 5. Difficultés rencontrées et solutions
### **1. Erreurs avec VirtualBox et Vagrant**
- Certaines versions récentes de VirtualBox ne sont pas compatibles avec Vagrant
- Solution : Mise à jour de Vagrant ou utilisation d'une version stable

### **2. Configuration du firewall**
- Problème : Blocage accidentel des connexions SSH
- Solution : Ajout explicite d'une règle autorisant SSH uniquement depuis le client

### **3. Sécurisation de Nginx**
- Initialement, Nginx exposait trop d'informations
- Solution : Désactivation des headers sensibles et restriction des méthodes HTTP

## 6. Améliorations possibles
- Ajout de HTTPS avec un certificat SSL/TLS auto-signé
- Monitoring en temps réel du firewall et des connexions
- Ajout d'un IDS (Intrusion Detection System) comme Fail2Ban

## 7. Conclusion
Ce projet démontre comment déployer un serveur sécurisé avec un firewall bien configuré et un serveur web protégé. Il permet également de tester concrètement les règles de sécurité mises en place via un script interactif.

L'approche adoptée pourrait être utilisée en entreprise pour protéger des serveurs exposés à Internet.

## Effectif

1. Fourneaux Mathéo
2. Francoise Paul 
