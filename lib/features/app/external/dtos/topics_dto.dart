import '../../domain/entities/topics.dart';

extension TopicsDTO on Topics {
  static Topics fromMap(Map<String, dynamic> map) {
    return Topics(
      temperature: map['temperature'] ?? 'temperature',
      humidity: map['humidity'] ?? 'humidity',
      airConditionerStatus:
          map['airConditionerStatus'] ?? 'airConditionerStatus',
      setAirConditionerStatus:
          map['setAirConditionerStatus'] ?? 'setAirConditionerStatus',
    );
  }
}
