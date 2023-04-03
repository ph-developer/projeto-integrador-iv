import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class ISetAirConditionerStatus {
  AsyncResult<bool, AppFailure> call(Ambient ambient, {required bool on});
}

class SetAirConditionerStatusImpl extends ISetAirConditionerStatus {
  final IAmbientRepository _ambientRepository;

  SetAirConditionerStatusImpl(this._ambientRepository);

  @override
  AsyncResult<bool, AppFailure> call(
    Ambient ambient, {
    required bool on,
  }) async {
    return _ambientRepository.setAirConditionerStatus(ambient, on: on);
  }
}
