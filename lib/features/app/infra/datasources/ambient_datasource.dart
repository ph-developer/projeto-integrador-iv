import '../../domain/entities/ambient.dart';

abstract class IAmbientDatasource {
  Future<List<Ambient>> getAmbients(List<String> ids);
  Future<Ambient> getAmbientById(String ambientId);
  Future<Ambient> saveAmbient(String id, Map<String, dynamic> data);
  Future<void> deleteAmbient(String ambientId);
}
