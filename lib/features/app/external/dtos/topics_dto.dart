import '../../domain/entities/topics.dart';

extension TopicsDTO on Topics {
  static Topics fromMap(Map<String, dynamic> map) {
    String prefix(String topic) => '${map['_prefix'] ?? ''}$topic';

    return Topics(
      temperature: prefix(
        map['temperature'] ?? 'temperature',
      ),
      humidity: prefix(
        map['humidity'] ?? 'humidity',
      ),
      airConditionerStatus: prefix(
        map['air_conditioner_status'] ?? 'airConditionerStatus',
      ),
      setAirConditionerStatus: prefix(
        map['set_air_conditioner_status'] ?? 'setAirConditionerStatus',
      ),
    );
  }
}
