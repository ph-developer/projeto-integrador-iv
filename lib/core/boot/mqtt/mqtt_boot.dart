import '../../mqtt/mqtt_ambient.dart';
import '../../mqtt/mqtt_broker.dart';

abstract class MqttBoot {
  static Future<void> run() async {
    final broker = MqttBroker.instance;

    //TODO: get ambients from firestore

    //TODO: set ambients in broker
    broker.addAmbient(
      MqttAmbient(
        'sala_01',
        'Sala 01',
        '10.0.2.2',
        1883,
        'mosquitto',
        'test',
      ),
    );
    // broker.addAmbient(
    //   MqttAmbient(
    //     'sala_01',
    //     'Sala 01',
    //     'mqtt.eclipseprojects.io',
    //     1883,
    //     '',
    //     '',
    //   ),
    // );

    await broker.connectAmbients();
  }
}
