import '../../domain/entities/access.dart';

abstract class IAccessDatasource {
  Future<Access?> getLoggedUserAccess();
  Future<void> addAccess(String ambientId);
  Future<void> removeAccess(String ambientId);
}
