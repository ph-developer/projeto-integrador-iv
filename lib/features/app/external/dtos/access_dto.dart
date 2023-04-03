import '../../domain/entities/access.dart';

extension AccessDTO on Access {
  static Access fromMap(Map<String, dynamic> map) {
    return Access(
      ambients: List<String>.from(map['ambients'] ?? []),
    );
  }
}
