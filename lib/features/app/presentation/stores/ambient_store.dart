import 'package:mobx/mobx.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/errors/failures.dart';
import '../../domain/usecases/get_real_time_air_conditioner_status.dart';
import '../../domain/usecases/get_real_time_humidity.dart';
import '../../domain/usecases/get_real_time_temperature.dart';
import '../../domain/usecases/turn_air_conditioner_off.dart';
import '../../domain/usecases/turn_air_conditioner_on.dart';

part 'ambient_store.g.dart';

class AmbientStore = _AmbientStoreBase with _$AmbientStore;

abstract class _AmbientStoreBase with Store {
  final IGetRealTimeTemperature _getRealTimeTemperature;
  final IGetRealTimeHumidity _getRealTimeHumidity;
  final IGetRealTimeAirConditionerStatus _getRealTimeAirConditionerStatus;
  final ITurnAirConditionerOn _turnAirConditionerOn;
  final ITurnAirConditionerOff _turnAirConditionerOff;

  _AmbientStoreBase(
    this._getRealTimeTemperature,
    this._getRealTimeHumidity,
    this._getRealTimeAirConditionerStatus,
    this._turnAirConditionerOn,
    this._turnAirConditionerOff,
  ) {
    _getRealTimeTemperature(ambientName).listen((value) => temperature = value);
    _getRealTimeHumidity(ambientName).listen((value) => humidity = value);
    _getRealTimeAirConditionerStatus(ambientName).listen((value) {
      isAirConditionerOn = value;
      isLoading = false;
    });
  }

  @observable
  bool isLoading = false;

  @observable
  String ambientName = 'sala_01';

  @observable
  double temperature = 0;

  @observable
  double humidity = 0;

  @observable
  bool isAirConditionerOn = false;

  @observable
  bool _isRecomendatedTurnAirConditionerOn = true;

  @computed
  bool get isRecomendatedTurnAirConditionerOn =>
      !isAirConditionerOn && _isRecomendatedTurnAirConditionerOn;

  @action
  Future<void> toggleAirConditionerStatus() async {
    isLoading = true;

    _isRecomendatedTurnAirConditionerOn = true;

    AsyncResult<bool, AppFailure> Function(String) usecase;
    if (!isAirConditionerOn) {
      usecase = _turnAirConditionerOn;
    } else {
      usecase = _turnAirConditionerOff;
    }

    await usecase(ambientName);
  }
}
