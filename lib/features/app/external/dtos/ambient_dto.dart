import '../../domain/entities/ambient.dart';
import 'topics_dto.dart';

extension AmbientDTO on Ambient {
  static Ambient fromMap(Map<String, dynamic> map) {
    return Ambient(
      id: map['id'],
      name: map['name'],
      host: map['host'],
      port: map['port'],
      username: map['username'],
      password: map['password'],
      topics: TopicsDTO.fromMap(
        Map<String, dynamic>.from(map['topics'] ?? {}),
      ),
    );
  }
}
