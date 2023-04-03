import 'package:equatable/equatable.dart';

import 'topics.dart';

class Ambient extends Equatable {
  final String id;
  final String name;
  final String host;
  final int port;
  final String username;
  final String password;
  final Topics topics;

  const Ambient({
    required this.id,
    required this.name,
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.topics,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        host,
        port,
        username,
        password,
        topics,
      ];
}
