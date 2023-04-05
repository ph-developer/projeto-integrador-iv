import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../entities/sensors.dart';
import '../errors/failures.dart';

abstract class IAmbientRepository {
  AsyncResult<List<Ambient>, AppFailure> getAmbients();
  AsyncResult<Ambient, AppFailure> getAmbientById(String ambientId);
  AsyncResult<Ambient, AppFailure> saveAmbient(
    String id,
    String name,
    String host,
    int port,
    String username,
    String password,
    String temperatureTopic,
    String humidityTopic,
    String airConditionerStatusTopic,
    String setAirConditionerStatusTopic,
  );
  AsyncResult<Unit, AppFailure> deleteAmbient(String ambientId);
  AsyncResult<Unit, AppFailure> closeAmbient(Ambient ambient);
  AsyncResult<Sensors, AppFailure> getAmbientSensors(Ambient ambient);
  AsyncResult<bool, AppFailure> setAirConditionerStatus(
    Ambient ambient, {
    required bool on,
  });
}
