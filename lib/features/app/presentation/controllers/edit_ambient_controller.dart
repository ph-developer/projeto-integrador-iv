// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/ambient.dart';
import '../../domain/errors/failures.dart';
import '../../domain/usecases/delete_ambient.dart';
import '../../domain/usecases/get_ambient_by_id.dart';
import '../../domain/usecases/save_ambient.dart';

part 'edit_ambient_controller.g.dart';

enum SuccessfulAction { save, delete }

class EditAmbientController = _EditAmbientControllerBase
    with _$EditAmbientController;

abstract class _EditAmbientControllerBase with Store {
  final IGetAmbientById _getAmbientById;
  final ISaveAmbient _saveAmbient;
  final IDeleteAmbient _deleteAmbient;

  _EditAmbientControllerBase(
    this._getAmbientById,
    this._saveAmbient,
    this._deleteAmbient,
  );

  @observable
  bool isFetching = true;

  @observable
  bool isSavingOrDeleting = false;

  @observable
  Ambient? ambient;

  @observable
  AppFailure? failure;

  @observable
  SuccessfulAction? success;

  @action
  Future<void> fetchAmbient(String? ambientId) async {
    if (isSavingOrDeleting) return;

    isFetching = true;
    ambient = null;

    if (ambientId != null) {
      final result = await _getAmbientById(ambientId);

      result.fold(
        (ambient) => this.ambient = ambient,
        (failure) => this.failure = failure,
      );
    }

    isFetching = false;
  }

  @action
  Future<void> saveAmbient(String? id, Map<String, String> payload) async {
    if (isFetching || isSavingOrDeleting) return;

    isSavingOrDeleting = true;
    failure = null;
    success = null;

    final name = payload['name'] ?? '';
    final host = payload['host'] ?? '';
    final port = payload['port'] ?? '';
    final username = payload['username'] ?? '';
    final password = payload['password'] ?? '';
    final temperatureTopic = payload['temperatureTopic'] ?? '';
    final humidityTopic = payload['humidityTopic'] ?? '';
    final airConditionerStatusTopic =
        payload['airConditionerStatusTopic'] ?? '';
    final setAirConditionerStatusTopic =
        payload['setAirConditionerStatusTopic'] ?? '';

    final result = await _saveAmbient(
      id ?? const Uuid().v4(),
      name,
      host,
      port,
      username,
      password,
      temperatureTopic,
      humidityTopic,
      airConditionerStatusTopic,
      setAirConditionerStatusTopic,
    );

    result.fold(
      (success) => this.success = SuccessfulAction.save,
      (failure) => this.failure = failure,
    );

    isSavingOrDeleting = false;
  }

  @action
  Future<void> deleteAmbient(String ambientId) async {
    if (isFetching || isSavingOrDeleting) return;

    isSavingOrDeleting = true;
    failure = null;
    success = null;

    final result = await _deleteAmbient(ambientId);

    result.fold(
      (success) => this.success = SuccessfulAction.delete,
      (failure) => this.failure = failure,
    );

    isSavingOrDeleting = false;
  }
}
