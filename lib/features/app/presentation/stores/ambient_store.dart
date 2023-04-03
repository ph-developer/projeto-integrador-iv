// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../../domain/entities/ambient.dart';
import '../../domain/entities/sensors.dart';
import '../../domain/errors/failures.dart';
import '../../domain/usecases/close_ambient.dart';
import '../../domain/usecases/get_ambient_by_id.dart';
import '../../domain/usecases/get_ambient_sensors.dart';
import '../../domain/usecases/set_air_conditioner_status.dart';

part 'ambient_store.g.dart';

class AmbientStore = _AmbientStoreBase with _$AmbientStore;

abstract class _AmbientStoreBase with Store {
  final IGetAmbientById _getAmbientById;
  final ICloseAmbient _closeAmbient;
  final IGetAmbientSensors _getAmbientSensors;
  final ISetAirConditionerStatus _setAirConditionerStatus;

  _AmbientStoreBase(
    this._getAmbientById,
    this._closeAmbient,
    this._getAmbientSensors,
    this._setAirConditionerStatus,
  );

  @observable
  bool isFetching = false;

  @observable
  bool isChangingAirConditionerStatus = false;

  @observable
  Ambient? ambient;

  @observable
  Sensors? sensors;

  @observable
  AppFailure? failure;

  @action
  Future<void> fetchAmbient(String ambientId) async {
    isFetching = true;
    ambient = null;
    sensors = null;

    final result1 = await _getAmbientById(ambientId);

    result1.fold(
      (ambient) => this.ambient = ambient,
      (failure) => this.failure = failure,
    );

    if (ambient == null) {
      isFetching = false;
      return;
    }

    final result2 = await _getAmbientSensors(ambient!);

    result2.fold(
      (sensors) => this.sensors = sensors,
      (failure) => this.failure = failure,
    );

    isFetching = false;
  }

  @action
  Future<void> closeAmbient() async {
    if (ambient == null) return;
    isFetching = true;

    final result = await _closeAmbient(ambient!);

    result.fold(
      (success) => null,
      (failure) => this.failure = failure,
    );

    isFetching = false;
  }

  @action
  Future<void> setAirConditionerStatus({required bool on}) async {
    //TODO:
    // isChangingAirConditionerStatus = true;

    final result = await _setAirConditionerStatus(ambient!, on: on);

    result.fold(
      (success) => null,
      (failure) => this.failure = failure,
    );
  }
}
