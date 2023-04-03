import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class IGetAmbients {
  AsyncResult<List<Ambient>, AppFailure> call();
}

class GetAmbientsImpl implements IGetAmbients {
  final IAmbientRepository _ambientRepository;

  GetAmbientsImpl(this._ambientRepository);

  @override
  AsyncResult<List<Ambient>, AppFailure> call() async {
    return _ambientRepository.getAmbients();
  }
}
