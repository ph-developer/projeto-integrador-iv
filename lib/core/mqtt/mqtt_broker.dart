import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'mqtt_ambient.dart';

class MqttBroker {
  static final MqttBroker _instance = MqttBroker._();
  MqttBroker._();
  static MqttBroker get instance => _instance;

  final Map<String, MqttAmbient> _ambients = {};
  final Map<String, MqttServerClient> _clients = {};
  final Map<String, bool> _status = {};
  final Map<String, dynamic> _topicSubscriptions = {};

  void addAmbient(MqttAmbient ambient) {
    _ambients[ambient.id] = ambient;
  }

  // void removeAmbient(MqttAmbient ambient) {
  //   _ambients.remove(ambient.id);
  // }

  Future<void> connectAmbients() async {
    await Future.wait(
      _ambients.values.map((ambient) => _connectAmbient(ambient.id)),
    );
  }

  Future<void> _connectAmbient(String ambientId) async {
    final ambient = _ambients[ambientId];

    if (ambient == null || _status[ambient.id] == true) return;

    _status[ambient.id] ??= false;

    final client = MqttServerClient(ambient.broker, ambient.clientId)
      ..logging(on: true)
      ..setProtocolV311()
      ..port = ambient.port
      ..keepAlivePeriod = 60
      ..clientIdentifier = ambient.clientId
      ..secure = false
      ..onConnected = (() => _status[ambient.id] = true)
      ..onDisconnected = (() => _status[ambient.id] = false);

    _clients[ambient.id] = client;

    try {
      await client.connect(ambient.username, ambient.password);
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  MqttServerClient _getClient(String ambientId) {
    final clientStatus = _status[ambientId];
    final client = _clients[ambientId];

    if (client == null) throw Exception('Client not exists.');
    if (clientStatus != true) throw Exception('Client disconnected.');

    return client;
  }

  Stream<double> subscribeDouble(String ambientId, String topic) {
    _subscribeTopic(ambientId, topic);

    return _getClient(ambientId)
        .updates!
        .map((events) => events.where((event) => event.topic == topic))
        .where((events) => events.isNotEmpty)
        .map((events) => events.first.payload as MqttPublishMessage)
        .map((payload) => payload.payload.message)
        .map(MqttPublishPayload.bytesToStringAsString)
        .map(double.tryParse)
        .where((value) => value != null)
        .map((value) => value!);
  }

  Stream<bool> subscribeBool(String ambientId, String topic) {
    _subscribeTopic(ambientId, topic);

    return _getClient(ambientId)
        .updates!
        .map((events) => events.where((event) => event.topic == topic))
        .where((events) => events.isNotEmpty)
        .map((events) => events.first.payload as MqttPublishMessage)
        .map((payload) => payload.payload.message)
        .map(MqttPublishPayload.bytesToStringAsString)
        .where((str) => str == 'true' || str == 'false')
        .map((str) => str == 'true');
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> publishBool(String ambientId, String topic, bool val) async {
    final data = MqttClientPayloadBuilder().addString(val.toString()).payload!;
    _getClient(ambientId).publishMessage(topic, MqttQos.atLeastOnce, data);
  }

  void _subscribeTopic(String ambientId, String topic) {
    final subscriptionId = '$ambientId:::$topic';
    final client = _getClient(ambientId);

    if (_topicSubscriptions.containsKey(subscriptionId)) return;

    final subscription = client.subscribe(topic, MqttQos.atLeastOnce);
    _topicSubscriptions[subscriptionId] = subscription;
  }
}
