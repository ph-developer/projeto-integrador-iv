import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class MqttAmbient extends Equatable {
  final String id;
  final String name;
  final String broker;
  final int port;
  final String username;
  final String password;
  final String clientId = const Uuid().v4();

  MqttAmbient(
    this.id,
    this.name,
    this.broker,
    this.port,
    this.username,
    this.password,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        broker,
        port,
        username,
        password,
        clientId,
      ];
}
