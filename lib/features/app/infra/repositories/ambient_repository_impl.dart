import 'package:result_dart/result_dart.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domain/errors/failures.dart';
import '../../domain/repositories/ambient_repository.dart';
import '../datasources/ambient_datasource.dart';

class AmbientRepositoryImpl extends IAmbientRepository {
  final IAmbientDatasource _ambientDatasource;
  final IErrorHandler _errorHandler;

  AmbientRepositoryImpl(this._ambientDatasource, this._errorHandler);

  @override
  Stream<double> getRealTimeTemperature(String ambientId) {
    return _ambientDatasource.getRealTimeTemperature(ambientId);
  }

  @override
  Stream<double> getRealTimeHumidity(String ambientId) {
    return _ambientDatasource.getRealTimeHumidity(ambientId);
  }

  @override
  Stream<bool> getRealTimeAirConditionerStatus(String ambientId) {
    return _ambientDatasource.getRealTimeAirConditionerStatus(ambientId);
  }

  @override
  AsyncResult<bool, AppFailure> turnAirConditionerOn(String ambientId) async {
    try {
      await _ambientDatasource.turnAirConditionerOn(ambientId);

      return const Success(true);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }

  @override
  AsyncResult<bool, AppFailure> turnAirConditionerOff(String ambientId) async {
    try {
      await _ambientDatasource.turnAirConditionerOff(ambientId);

      return const Success(true);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (exception, stackTrace) {
      await _errorHandler.reportException(exception, stackTrace);
      return const Failure(UnknownError());
    }
  }
}
