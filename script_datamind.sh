#!/bin/bash
docker --version #verifica versao atual do docker
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
        echo "docker instalado" #print no terminal
else #se nao,
        echo "docker não instalado" #print no terminal
        echo "Instalando docker..." #print no terminal
        sudo apt update && sudo apt upgrade -y
        sudo apt install docker.io -y
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

curl -o docker-compose.yml https://raw.githubusercontent.com/DataMind-SPTECH/container/main/docker-compose.yml

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
read -p "LINK SLACK: " linkSlack

# Inicia os containers com as variáveis de ambiente
export AWS_ACCESS_KEY_ID=$awsAccessKeyId
export AWS_SECRET_ACCESS_KEY=$awsSecretAccessKey
export AWS_SESSION_TOKEN=$awsSessionToken
export LINK_SLACK=$linkSlack
export DB_HOST="mysql"
export DB_DATABASE="datamind"
export DB_USER="datamind_adm"
export DB_PASSWORD="datamind_adm"
export DB_PORT="3306"
export NAME_BUCKET="datamind-bucket"

sudo -E docker-compose up -d

if [ $? = 0 ];
then echo "Compose rodando em segundo plano"
        else
        echo "Execução em segundo plano falhou, iniciando normalmente"
             sudo docker-compose up
fi #fecha o 1º if

cat <<EOF > run_datamind.sh
#!/bin/bash
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN DB_HOST=$DB_HOST DB_DATABASE=$DB_DATABASE DB_USER=$DB_USER DB_PASSWORD=$DB_PASSWORD DB_PORT=$DB_PORT NAME_BUCKET=$NAME_BUCKET LINK_SLACK=$LINK_SLACK /usr/local/openjdk-21/bin/java -jar /app/Projeto-JAVA.jar >> /var/log/cron.log 2>&1
EOF

# Torna o script executável
chmod +x run_datamind.sh

# Copia o script para o container Java
sudo docker cp run_datamind.sh container_datamind_java:/app/run_datamind.sh

# Cria o cronjob dentro do container Java
sudo docker exec -it container_datamind_java bash -c "echo '0 * * * * root /app/run_datamind.sh' > /etc/cron.d/datamind_cron && chmod 644 /etc/cron.d/datamind_cron && crontab /etc/cron.d/datamind_cron && service cron restart"

# Reescrevendo o .env.dev
cat <<EOF > .env.dev
AMBIENTE_PROCESSO=desenvolvimento

# Configurações de conexão com o banco de dados
DB_HOST=$DB_HOST
DB_DATABASE=$DB_DATABASE
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
DB_PORT=$DB_PORT

# Configurações do servidor de aplicação
APP_PORT=3333
APP_HOST=localhost

# GEMINI API KEY

GEMINI_API='AIzaSyDvkhMiz-PaFvnnaHHWgxjsh8tV4pylVik'

# importante: caso sua senha contenha caracteres especiais, insira-a entre 'aspas'
EOF

# Copia o .env.dev para o container Site
sudo docker cp .env.dev container_datamind_site:/app/.env.dev

# Rodar o script
sudo docker exec -it container_datamind_java bash -c "sleep 30 && java -jar Projeto-JAVA.jar"

echo "Configuração completa."
