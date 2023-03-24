import 'package:auto_injector/auto_injector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_integrador_iv/core/errors/error_handler.dart';
import 'package:projeto_integrador_iv/core/errors/error_handler_impl.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/do_login.dart';
import '../../features/auth/domain/usecases/do_logout.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/external/datasources/auth_datasource_impl.dart';
import '../../features/auth/infra/datasources/auth_datasource.dart';
import '../../features/auth/infra/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/stores/auth_store.dart';

typedef Injector = AutoInjector;
typedef InjectFn = Future<void> Function(Injector injector);

AutoInjector _injector = AutoInjector();
T inject<T>() => _injector<T>();

@visibleForTesting
void setInjector(AutoInjector injector) {
  _injector = injector;
}

Future<void> setupInjector([InjectFn? injectFn]) async {
  if (injectFn != null) return injectFn(_injector);

  await _injectCore(_injector);
  await _injectAuthFeature(_injector);

  _injector.commit();
}

Future<void> _injectCore(Injector injector) async {
  injector
    //! Firebase
    ..addSingleton<FirebaseAuth>(() => FirebaseAuth.instance)

    //! Core
    ..add<IErrorHandler>(ErrorHandlerImpl.new);
}

Future<void> _injectAuthFeature(Injector injector) async {
  injector
    //! Datasources
    ..add<IAuthDatasource>(AuthDatasourceImpl.new)

    //! Repositories
    ..add<IAuthRepository>(AuthRepositoryImpl.new)

    //! Usecases
    ..add<IDoLogin>(DoLoginImpl.new)
    ..add<IDoLogout>(DoLogoutImpl.new)
    ..add<IGetCurrentUser>(GetCurrentUserImpl.new)

    //! Stores
    ..addSingleton<AuthStore>(AuthStore.new);
}
