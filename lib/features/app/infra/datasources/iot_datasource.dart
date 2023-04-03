import '../../domain/entities/ambient.dart';
import '../../domain/entities/sensors.dart';

abstract class IIotDatasource {
  Future<void> connectAmbient(Ambient ambient);
  Future<void> disconnectAmbient(Ambient ambient);
  Future<Sensors> getAmbientSensors(Ambient ambient);
  Future<void> setAirConditionerStatus(Ambient ambient, {required bool on});
}
