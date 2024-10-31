#!/bin/bash

java -version #verifica versao atual do java
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
	echo "java instalado" #print no terminal
else #se nao,
	echo "java não instalado" #print no terminal
	echo "gostaria de instalar o java? [s/n]" #print no terminal
	read get #variável que guarda resposta do usuário
	if [ \"$get\" == \"s\" ]; #se retorno for igual a s
then #entao
	sudo apt install openjdk-17-jre -y #executa instalacao do java
	fi #fecha o 2º if
fi #fecha o 1º if

docker --version #verifica versao atual do docker
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
        echo "docker instalado" #print no terminal
else #se nao,
        echo "docker não instalado" #print no terminal
        echo "gostaria de instalar o docker? [s/n]" #print no terminal
        read get #variável que guarda resposta do usuário
        if [ \"$get\" == \"s\" ]; #se retorno for igual a s
then #entao
        sudo apt install docker.io
	sudo systemctl start docker
	sudo systemctl enable docker
        fi #fecha o 2º if
fi #fecha o 1º if


sudo docker pull ryanzin1380/datamind:1.0
sudo docker pull ryanzin1380/datamind_bd:1.0


sudo docker-compose version #verifica versao atual do compose
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
        echo "docker compose instalado" #print no terminal
else #se nao,
        echo "docker compose não instalado" #print no terminal
        echo "gostaria de instalar o docker-compose? [s/n]" #print no terminal
        read get #variável que guarda resposta do usuário
        if [ \"$get\" == \"s\" ]; #se retorno for igual a s
then #entao
         sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  #executa instalacao do compose
	 sudo chmod +x /usr/local/bin/docker-compose
	fi #fecha o 2º if
fi #fecha o 1º if

if sudo docker-compose up -d;
then echo "Compose rodando em segundo plano"
        else
        echo "Execução em segundo plano falhou, iniciando normalmente"
             sudo docker-compose up
fi #fecha o 1º if

