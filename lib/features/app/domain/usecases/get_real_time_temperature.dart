import '../repositories/ambient_repository.dart';

abstract class IGetRealTimeTemperature {
  Stream<double> call(String ambientId);
}

class GetRealTimeTemperatureImpl extends IGetRealTimeTemperature {
  final IAmbientRepository _ambientRepository;

  GetRealTimeTemperatureImpl(this._ambientRepository);

  @override
  Stream<double> call(String ambientId) {
    return _ambientRepository.getRealTimeTemperature(ambientId);
  }
}
