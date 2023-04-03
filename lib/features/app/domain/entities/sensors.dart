import 'package:equatable/equatable.dart';

class Sensors extends Equatable {
  final Stream<double>? temperature;
  final Stream<double>? humidity;
  final Stream<bool>? airConditionerStatus;

  const Sensors({
    this.temperature,
    this.humidity,
    this.airConditionerStatus,
  });

  @override
  List<Object?> get props => [
        temperature,
        humidity,
        airConditionerStatus,
      ];
}
