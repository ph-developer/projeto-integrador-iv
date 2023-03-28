## Comando para criar o primeiro usuário

docker-compose exec mosquitto mosquitto_passwd -c /mosquitto/conf/mosquitto.passwd mosquitto

## Comando para criar outro usuário

docker-compose exec mosquitto mosquitto_passwd -b /mosquitto/conf/mosquitto.passwd {usuário} {senha}

## Comando para rodar o container

docker-compose up
ou
docker-compose up -d

## Comando para escutar um tópico (sub)

docker-compose exec mosquitto mosquitto_sub -v -t '{tópico}' -u {usuário} -P {senha}

## Comando para publicar uma mensagem em um tópico (pub)

docker-compose exec mosquitto mosquitto_pub -t '{tópico}' -m {mensagem} -u {usuário} -P {senha}

## Informações

Por padrão, o mosquitto escutará as portas 1883 (MQTT) e 9001 (WS).
O container já possui um usuário para testes criado: 'mosquitto', e sua senha é 'test'.