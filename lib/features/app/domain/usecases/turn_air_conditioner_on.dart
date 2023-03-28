import 'package:result_dart/result_dart.dart';

import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class ITurnAirConditionerOn {
  AsyncResult<bool, AppFailure> call(String ambientId);
}

class TurnAirConditionerOnImpl extends ITurnAirConditionerOn {
  final IAmbientRepository _ambientRepository;

  TurnAirConditionerOnImpl(this._ambientRepository);

  @override
  AsyncResult<bool, AppFailure> call(String ambientId) async {
    if (ambientId.isEmpty) {
      return const Failure(
        InvalidInput('O campo "ambiente" deve ser preenchido.'),
      );
    }

    return _ambientRepository.turnAirConditionerOn(ambientId);
  }
}
