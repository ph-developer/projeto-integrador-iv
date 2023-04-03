import 'package:equatable/equatable.dart';

class Access extends Equatable {
  final List<String> ambients;

  const Access({
    required this.ambients,
  });

  @override
  List<Object?> get props => [
        ambients,
      ];
}
