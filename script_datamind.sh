#!/bin/bash
docker --version #verifica versao atual do docker
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
        echo "docker instalado" #print no terminal
else #se nao,
        echo "docker não instalado" #print no terminal
        echo "Instalando docker..." #print no terminal
        sudo apt install docker.io
	sudo systemctl start docker
	sudo systemctl enable docker
fi #fecha o 1º if

curl --version
if [ $? = 0 ];
then
	echo "curl instalado"
else
	echo "instalando curl..."
	sudo apt install curl
if

sudo docker pull ryanzin1380/datamind:1.0
sudo docker pull ryanzin1380/datamind_bd:1.0
sudo docker pull anilmar/datamind_java:1.0

curl -o cronjob https://raw.githubusercontent.com/DataMind-SPTECH/container/main/cronjob
mkdir arquivos_sql
curl -o ./arquivos_sql/banco_datamind.sql https://raw.githubusercontent.com/DataMind-SPTECH/container/main/arquivos_sql/banco_datamind.sql

sudo docker-compose version #verifica versao atual do compose
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
        echo "docker compose instalado" #print no terminal
else #se nao,
        echo "docker compose não instalado" #print no terminal
        echo "instalando docker compose..." #print no terminal
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  #executa instalacao do compose
	sudo chmod +x /usr/local/bin/docker-compose
fi #fecha o 1º if

echo "Por favor, insira as variáveis de ambiente necessárias:"

read -p "AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
read -p "AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
read -p "AWS_SESSION_TOKEN: " AWS_SESSION_TOKEN
read -p "DB_USER: " DB_USER
read -p "DB_PASSWORD: " DB_PASSWORD
read -p "NAME_BUCKET: " NAME_BUCKET

# Inicia os containers com as variáveis de ambiente
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
DB_USER=$DB_USER \
DB_PASSWORD=$DB_PASSWORD \
NAME_BUCKET=$NAME_BUCKET \
sudo docker-compose up -d

if [ $? - 0 ];
then echo "Compose rodando em segundo plano"
        else
        echo "Execução em segundo plano falhou, iniciando normalmente"
             sudo docker-compose up
fi #fecha o 1º if

