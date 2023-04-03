import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class ICloseAmbient {
  AsyncResult<Unit, AppFailure> call(Ambient ambient);
}

class CloseAmbientImpl implements ICloseAmbient {
  final IAmbientRepository _ambientRepository;

  CloseAmbientImpl(this._ambientRepository);

  @override
  AsyncResult<Unit, AppFailure> call(Ambient ambient) async {
    return _ambientRepository.closeAmbient(ambient);
  }
}
