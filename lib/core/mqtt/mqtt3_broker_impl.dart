import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

import 'mqtt_broker.dart';
import 'mqtt_exceptions.dart';

class Mqtt3Broker implements IMqttBroker {
  final Map<String, MqttServerClient> _clients = {};

  @override
  Future<void> connect(
    String id,
    String host,
    int port,
    String username,
    String password,
  ) async {
    if (_clients.containsKey(id)) {
      final client = _clients[id]!;
      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        return;
      }
    }

    final client = MqttServerClient.withPort(host, const Uuid().v4(), port)
      ..setProtocolV311()
      ..logging(on: true)
      ..keepAlivePeriod = 60
      ..secure = false
      ..autoReconnect = true;

    try {
      await client.connect('${username}8', password);
      _clients[id] = client;
    } catch (e) {
      client.disconnect();

      if (e is SocketException && e.message == 'Connection timed out') {
        throw ServerUnreachableException();
      } else if (e is NoConnectionException) {
        throw InvalidCredentialsException();
      }
    }
  }

  @override
  Future<void> disconnect(String connectionId) async {
    if (_clients.containsKey(connectionId)) {
      _clients[connectionId]!.disconnect();
      _clients.remove(connectionId);
    }
  }

  @override
  Future<void> publish<T>(String connectionId, String topic, T value) async {
    final client = _getClient(connectionId);

    if (client != null) {
      final builder = MqttClientPayloadBuilder();

      if (value is String) {
        builder.addString(value);
      } else if (value is int) {
        builder.addInt(value);
      } else if (value is double) {
        builder.addDouble(value);
      } else if (value is bool) {
        builder.addBool(val: value);
      } else {
        throw Exception('Publish type $T is not implemented.');
      }

      final payload = builder.payload!;
      client.publishMessage(topic, MqttQos.atLeastOnce, payload, retain: true);
    }
  }

  @override
  Stream<T> subscribe<T>(String connectionId, String topic, T initial) async* {
    yield initial;
    final client = _getClient(connectionId);

    if (client != null) {
      final stream = client.updates!
          .map((events) => events.where((event) => event.topic == topic))
          .where((events) => events.isNotEmpty)
          .map((events) => events.first.payload as MqttPublishMessage)
          .map((payload) => payload.payload.message)
          .map((bytes) {
        if (bytes.length == 1) {
          if (bytes.first == 1) return 'true';
          if (bytes.first == 0) return 'false';
        }
        return MqttPublishPayload.bytesToStringAsString(bytes);
      });

      client.subscribe(topic, MqttQos.atLeastOnce);

      if (initial is String) {
        yield* stream.map((value) => value as T);
      } else if (initial is int) {
        yield* stream
            .map(int.tryParse)
            .where((value) => value != null)
            .map((value) => value!)
            .map((value) => value as T);
      } else if (initial is double) {
        yield* stream
            .map(double.tryParse)
            .where((value) => value != null)
            .map((value) => value!)
            .map((value) => value as T);
      } else if (initial is bool) {
        yield* stream
            .where((str) => str == 'true' || str == 'false')
            .map((str) => str == 'true')
            .map((value) => value as T);
      } else {
        throw Exception('Subscribe type $T is not implemented.');
      }
    }
  }

  MqttServerClient? _getClient(String connectionId) {
    return _clients[connectionId];
  }
}
