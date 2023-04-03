import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../entities/sensors.dart';
import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class IGetAmbientSensors {
  AsyncResult<Sensors, AppFailure> call(Ambient ambient);
}

class GetAmbientSensorsImpl implements IGetAmbientSensors {
  final IAmbientRepository _ambientRepository;

  GetAmbientSensorsImpl(this._ambientRepository);

  @override
  AsyncResult<Sensors, AppFailure> call(Ambient ambient) async {
    return _ambientRepository.getAmbientSensors(ambient);
  }
}
