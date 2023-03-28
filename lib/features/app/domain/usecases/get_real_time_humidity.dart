import '../repositories/ambient_repository.dart';

abstract class IGetRealTimeHumidity {
  Stream<double> call(String ambientId);
}

class GetRealTimeHumidityImpl extends IGetRealTimeHumidity {
  final IAmbientRepository _ambientRepository;

  GetRealTimeHumidityImpl(this._ambientRepository);

  @override
  Stream<double> call(String ambientId) {
    return _ambientRepository.getRealTimeHumidity(ambientId);
  }
}
