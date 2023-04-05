import 'package:result_dart/result_dart.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/ambient.dart';
import '../../domain/entities/sensors.dart';
import '../../domain/errors/failures.dart';
import '../../domain/repositories/ambient_repository.dart';
import '../datasources/access_datasource.dart';
import '../datasources/ambient_datasource.dart';
import '../datasources/iot_datasource.dart';

class AmbientRepositoryImpl extends IAmbientRepository {
  final IAmbientDatasource _ambientDatasource;
  final IAccessDatasource _accessDatasource;
  final IIotDatasource _iotDatasource;
  final IErrorHandler _errorHandler;

  AmbientRepositoryImpl(
    this._ambientDatasource,
    this._accessDatasource,
    this._iotDatasource,
    this._errorHandler,
  );

  @override
  AsyncResult<List<Ambient>, AppFailure> getAmbients() async {
    try {
      final access = await _accessDatasource.getLoggedUserAccess();

      if (access == null || access.ambients.isEmpty) {
        return const Success([]);
      }

      final ambients = await _ambientDatasource.getAmbients(access.ambients);

      return Success(ambients);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<Ambient, AppFailure> getAmbientById(String ambientId) async {
    try {
      final ambient = await _ambientDatasource.getAmbientById(ambientId);

      await _iotDatasource.connectAmbient(ambient);

      return Success(ambient);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<Ambient, AppFailure> saveAmbient(
    String id,
    String name,
    String host,
    int port,
    String username,
    String password,
    String temperatureTopic,
    String humidityTopic,
    String airConditionerStatusTopic,
    String setAirConditionerStatusTopic,
  ) async {
    try {
      final data = {
        'name': name,
        'host': host,
        'port': port,
        'username': username,
        'password': password,
        'topics': {
          'temperature': temperatureTopic,
          'humidity': humidityTopic,
          'airConditionerStatus': airConditionerStatusTopic,
          'setAirConditionerStatus': setAirConditionerStatusTopic,
        }
      };
      final ambient = await _ambientDatasource.saveAmbient(id, data);
      await _accessDatasource.addAccess(ambient.id);

      return Success(ambient);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<Unit, AppFailure> deleteAmbient(String ambientId) async {
    try {
      await _ambientDatasource.deleteAmbient(ambientId);
      await _accessDatasource.removeAccess(ambientId);

      return const Success(unit);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<Unit, AppFailure> closeAmbient(Ambient ambient) async {
    try {
      await _iotDatasource.disconnectAmbient(ambient);

      return const Success(unit);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<Sensors, AppFailure> getAmbientSensors(Ambient ambient) async {
    try {
      final result = await _iotDatasource.getAmbientSensors(ambient);

      return Success(result);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<bool, AppFailure> setAirConditionerStatus(
    Ambient ambient, {
    required bool on,
  }) async {
    try {
      await _iotDatasource.setAirConditionerStatus(ambient, on: on);

      return const Success(true);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }
}
