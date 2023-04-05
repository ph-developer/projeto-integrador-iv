<a name="readme-top"></a>

<h1 align="center">Projeto Integrador IV</h1>

<div align="center">
<p>Aplicativo mobile para controle de aparelhos de ar condicionado, para atendimento ao Projeto Integrador em Computação IV (UNIVESP) - Turma 001 - Grupo 002.</p>
<br>

[![architecture: Clean Dart](https://img.shields.io/badge/architecture-clean__dart-blueviolet)](https://github.com/Flutterando/Clean-Dart)
[![style: Flutterando analysis](https://img.shields.io/badge/style-flutterando__analysis-blueviolet)](https://pub.dev/packages/flutterando_analysis)
</div>

<details>
  <summary>Conteúdo</summary>
  <ol>
    <li><a href="#containers-docker">Containers Docker</a></li>
    <li><a href="#usuário-para-testes">Usuário para Testes</a></li>
  </ol>
</details>

<br>

## Containers Docker

<br>

No projeto há um stack docker contendo dois containers:
- <b>mosquitto</b>: utilizado como broker mqtt para testes. Possui apenas um usuário cadastrado, sob nome 'mosquitto', e senha 'test'. Este container escuta duas portas, 1883 (MQTT) e 9001 (WS).
- <b>node-red</b>: utilizado para 'mockar' os dados de sensores (temperatura, umidade e status do ar condicionado) para testes. Este container publica nos tópicos 'salaTeste/temperature', 'salaTeste/humidity' e 'salaTeste/airConditionerStatus'; e subscreve o tópico 'salaTeste/setAirConditionerStatus'.

Para inicializar o stack, basta executar o seguinte comando:
```shell
docker-compose up
```

Para subscrever um tópico via cli, basta executar o seguinte comando:
```shell
docker-compose exec mosquitto mosquitto_sub -v -q 1 -t '[tópico]' -u [usuário] -P [senha]
```

Para publicar em um tópico via cli, basta executar o seguinte comando:
```shell
docker-compose exec mosquitto mosquitto_pub -r -q 1 -t '[tópico]' -m [mensagem] -u [usuário] -P [senha]
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usuário para Testes

<br>

Para o propósito de testes, o aplicativo possui um usuário, sendo este:
- <b>email:</b> test@test.dev
- <b>password:</b> 123456

<p align="right">(<a href="#readme-top">back to top</a>)</p>
