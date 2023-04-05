import 'package:result_dart/result_dart.dart';

import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class IDeleteAmbient {
  AsyncResult<Unit, AppFailure> call(String ambientId);
}

class DeleteAmbientImpl implements IDeleteAmbient {
  final IAmbientRepository _ambientRepository;

  DeleteAmbientImpl(this._ambientRepository);

  @override
  AsyncResult<Unit, AppFailure> call(String ambientId) async {
    return _ambientRepository.deleteAmbient(ambientId);
  }
}
