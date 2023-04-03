import 'package:result_dart/result_dart.dart';

import '../entities/ambient.dart';
import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class IGetAmbientById {
  AsyncResult<Ambient, AppFailure> call(String ambientId);
}

class GetAmbientByIdImpl implements IGetAmbientById {
  final IAmbientRepository _ambientRepository;

  GetAmbientByIdImpl(this._ambientRepository);

  @override
  AsyncResult<Ambient, AppFailure> call(String ambientId) async {
    return _ambientRepository.getAmbientById(ambientId);
  }
}
