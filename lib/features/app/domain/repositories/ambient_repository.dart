import 'package:result_dart/result_dart.dart';

import '../errors/failures.dart';

abstract class IAmbientRepository {
  Stream<double> getRealTimeTemperature(String ambientId);
  Stream<double> getRealTimeHumidity(String ambientId);
  Stream<bool> getRealTimeAirConditionerStatus(String ambientId);
  AsyncResult<bool, AppFailure> turnAirConditionerOn(String ambientId);
  AsyncResult<bool, AppFailure> turnAirConditionerOff(String ambientId);
}
