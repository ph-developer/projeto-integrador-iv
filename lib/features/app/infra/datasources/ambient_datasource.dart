abstract class IAmbientDatasource {
  Stream<double> getRealTimeTemperature(String ambientId);
  Stream<double> getRealTimeHumidity(String ambientId);
  Stream<bool> getRealTimeAirConditionerStatus(String ambientId);
  Future<bool> turnAirConditionerOn(String ambientId);
  Future<bool> turnAirConditionerOff(String ambientId);
}
