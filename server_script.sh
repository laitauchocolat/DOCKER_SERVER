
#!/bin/bash

echo "--Copie des certificats et remplacement des anciens--";
sudo cp /home/julien-server/dehydrated/certs/laitauchocolat.duckdns.org/cert.pem /home/julien-server/docker-server/certificates/portainer/;
sudo cp /home/julien-server/dehydrated/certs/laitauchocolat.duckdns.org/privkey.pem /home/julien-server/docker-server/certificates/portainer/;
sudo cp /home/julien-server/dehydrated/certs/laitauchocolat.duckdns.org/cert.pem /home/julien-server/docker-server/certificates/onlyoffice/certs/;
sudo cp /home/julien-server/dehydrated/certs/laitauchocolat.duckdns.org/privkey.pem /home/julien-server/docker-server/certificates/onlyoffice/certs/;
sudo rm /home/julien-server/docker-server/certificates/onlyoffice/certs/onlyoffice.crt;
sudo rm /home/julien-server/docker-server/certificates/onlyoffice/certs/onlyoffice.key;
sudo mv /home/julien-server/docker-server/certificates/onlyoffice/certs/cert.pem /home/julien-server/docker-server/certificates/onlyoffice/certs/onlyoffice.crt;
sudo mv /home/julien-server/docker-server/certificates/onlyoffice/certs/privkey.pem /home/julien-server/docker-server/certificates/onlyoffice/certs/onlyoffice.key;

echo "--Arret de docker--";
cd /home/julien-server/docker-server/;
/snap/bin/docker-compose down;
docker rm $(docker ps -a -f status=exited -q)

echo "--Redemarrer docker--";
/snap/bin/docker-compose build --pull;
/snap/bin/docker-compose up -d;

echo "--Mise a jour ubuntu--";
sudo apt-get update;
sudo apt-get upgrade -y;
sudo apt-get dist-upgrade -y;
sudo apt-get autoremove -y;
docker system prune -a --volumes -f;

