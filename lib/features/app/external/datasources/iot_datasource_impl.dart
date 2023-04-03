import '../../../../core/mqtt/mqtt_broker.dart';
import '../../../../core/mqtt/mqtt_exceptions.dart';
import '../../domain/entities/ambient.dart';
import '../../domain/entities/sensors.dart';
import '../../domain/errors/failures.dart';
import '../../infra/datasources/iot_datasource.dart';

class IotDatasourceImpl implements IIotDatasource {
  final IMqttBroker _mqttBroker;

  IotDatasourceImpl(
    this._mqttBroker,
  );

  @override
  Future<void> connectAmbient(Ambient ambient) async {
    final connectionId = _getConnectionIdFromAmbient(ambient);

    try {
      await _mqttBroker.connect(
        connectionId,
        ambient.host,
        ambient.port,
        ambient.username,
        ambient.password,
      );
    } on ServerUnreachableException catch (_) {
      throw const AmbientConnectionFailure();
    } on InvalidCredentialsException catch (_) {
      throw const AmbientConnectionFailure();
    }
  }

  @override
  Future<void> disconnectAmbient(Ambient ambient) async {
    final connectionId = _getConnectionIdFromAmbient(ambient);

    await _mqttBroker.disconnect(connectionId);
  }

  @override
  Future<Sensors> getAmbientSensors(Ambient ambient) async {
    final sensors = Sensors(
      temperature: _getRealTimeTemperature(ambient),
      humidity: _getRealTimeHumidity(ambient),
      airConditionerStatus: _getRealTimeAirConditionerStatus(ambient),
    );

    return sensors;
  }

  @override
  Future<void> setAirConditionerStatus(
    Ambient ambient, {
    required bool on,
  }) async {
    final connectionId = _getConnectionIdFromAmbient(ambient);
    await _mqttBroker.publish(
      connectionId,
      ambient.topics.setAirConditionerStatus,
      on,
    );
  }

  Stream<double> _getRealTimeTemperature(Ambient ambient) {
    final connectionId = _getConnectionIdFromAmbient(ambient);
    return _mqttBroker.subscribe<double>(
      connectionId,
      ambient.topics.temperature,
      double.nan,
    );
  }

  Stream<double> _getRealTimeHumidity(Ambient ambient) {
    final connectionId = _getConnectionIdFromAmbient(ambient);
    return _mqttBroker.subscribe<double>(
      connectionId,
      ambient.topics.humidity,
      double.nan,
    );
  }

  Stream<bool> _getRealTimeAirConditionerStatus(Ambient ambient) {
    final connectionId = _getConnectionIdFromAmbient(ambient);
    return _mqttBroker.subscribe<bool>(
      connectionId,
      ambient.topics.airConditionerStatus,
      false,
    );
  }

  String _getConnectionIdFromAmbient(Ambient ambient) {
    return 'ambient@${ambient.host}:${ambient.port}';
  }
}
