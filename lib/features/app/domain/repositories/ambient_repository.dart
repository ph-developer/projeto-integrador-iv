import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../entities/sensors.dart';
import '../errors/failures.dart';

abstract class IAmbientRepository {
  AsyncResult<List<Ambient>, AppFailure> getAmbients();
  AsyncResult<Ambient, AppFailure> getAmbientById(String ambientId);
  AsyncResult<Unit, AppFailure> closeAmbient(Ambient ambient);
  AsyncResult<Sensors, AppFailure> getAmbientSensors(Ambient ambient);
  AsyncResult<bool, AppFailure> setAirConditionerStatus(
    Ambient ambient, {
    required bool on,
  });
}
