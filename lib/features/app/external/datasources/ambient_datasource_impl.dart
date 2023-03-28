import '../../../../core/mqtt/mqtt_broker.dart';
import '../../infra/datasources/ambient_datasource.dart';

class AmbientDatasourceImpl extends IAmbientDatasource {
  final MqttBroker _mqttBroker;

  AmbientDatasourceImpl(this._mqttBroker);

  @override
  Stream<double> getRealTimeTemperature(String ambientId) {
    return _mqttBroker.subscribeDouble(ambientId, 'temperature');
  }

  @override
  Stream<double> getRealTimeHumidity(String ambientId) {
    return _mqttBroker.subscribeDouble(ambientId, 'humidity');
  }

  @override
  Stream<bool> getRealTimeAirConditionerStatus(String ambientId) {
    return _mqttBroker.subscribeBool(ambientId, 'airConditionerStatus');
  }

  @override
  Future<bool> turnAirConditionerOn(String ambientId) async {
    await _mqttBroker.publishBool(ambientId, 'setAirConditionerStatus', true);
    await _mqttBroker.publishBool(ambientId, 'airConditionerStatus', true);
    return true;
  }

  @override
  Future<bool> turnAirConditionerOff(String ambientId) async {
    await _mqttBroker.publishBool(ambientId, 'setAirConditionerStatus', false);
    await _mqttBroker.publishBool(ambientId, 'airConditionerStatus', false);
    return true;
  }
}
