import 'package:equatable/equatable.dart';

class Topics extends Equatable {
  final String temperature;
  final String humidity;
  final String airConditionerStatus;
  final String setAirConditionerStatus;

  const Topics({
    this.temperature = '',
    this.humidity = '',
    this.airConditionerStatus = '',
    this.setAirConditionerStatus = '',
  });

  @override
  List<Object?> get props => [
        temperature,
        humidity,
        airConditionerStatus,
        setAirConditionerStatus,
      ];
}
