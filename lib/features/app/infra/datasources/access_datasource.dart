import '../../domain/entities/access.dart';

abstract class IAccessDatasource {
  Future<Access?> getLoggedUserAccess();
}
