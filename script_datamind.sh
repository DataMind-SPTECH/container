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
fi

sudo docker pull anilmar/datamind:1.0
sudo docker pull anilmar/datamind_bd:1.0
sudo docker pull anilmar/datamind_java:1.0

curl -o cronjob https://raw.githubusercontent.com/DataMind-SPTECH/container/main/cronjob
curl -o docker-compose.yml https://raw.githubusercontent.com/DataMind-SPTECH/container/main/docker-compose.yml
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

read -p "AWS ACCESS KEY ID: " awsAccessKeyId
read -p "AWS SECRET ACCESS KEY: " awsSecretAccessKey
read -p "AWS SESSION TOKEN: " awsSessionToken
read -p "DB HOST: " dbHost
read -p "DB USER: " dbUser
read -p "DB PASSWORD: " dbPassword
read -p "NAME BUCKET: " nameBucket

# Inicia os containers com as variáveis de ambiente
export AWS_ACCESS_KEY_ID=$awsAccessKeyId
export AWS_SECRET_ACCESS_KEY=$awsSecretAccessKey
export AWS_SESSION_TOKEN=$awsSessionToken
export DB_HOST=$dbHost
export DB_USER=$dbUser
export DB_PASSWORD=$dbPassword
export NAME_BUCKET=$nameBucket

sudo -E docker-compose up -d

if [ $? = 0 ];
then echo "Compose rodando em segundo plano"
        else
        echo "Execução em segundo plano falhou, iniciando normalmente"
             sudo docker-compose up
fi #fecha o 1º if
