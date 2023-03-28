import '../repositories/ambient_repository.dart';

abstract class IGetRealTimeAirConditionerStatus {
  Stream<bool> call(String ambientId);
}

class GetRealTimeAirConditionerStatusImpl
    extends IGetRealTimeAirConditionerStatus {
  final IAmbientRepository _ambientRepository;

  GetRealTimeAirConditionerStatusImpl(this._ambientRepository);

  @override
  Stream<bool> call(String ambientId) {
    return _ambientRepository.getRealTimeAirConditionerStatus(ambientId);
  }
}
