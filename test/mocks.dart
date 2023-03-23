// ignore_for_file: subtype_of_sealed_class

import 'package:auto_injector/auto_injector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:projeto_integrador_iv/core/errors/error_handler.dart';
import 'package:projeto_integrador_iv/core/helpers/snackbar_helper.dart';
import 'package:projeto_integrador_iv/features/auth/domain/errors/failures.dart';
import 'package:projeto_integrador_iv/features/auth/domain/repositories/auth_repository.dart';
import 'package:projeto_integrador_iv/features/auth/domain/usecases/do_login.dart';
import 'package:projeto_integrador_iv/features/auth/domain/usecases/do_logout.dart';
import 'package:projeto_integrador_iv/features/auth/domain/usecases/get_current_user.dart';
import 'package:projeto_integrador_iv/features/auth/infra/datasources/auth_datasource.dart';
import 'package:projeto_integrador_iv/features/auth/presentation/stores/auth_store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class Callable<T, U, V> {
  void call([T? p0, U? p1, V? p2]) {}
}

class MockCallable<T, U, V> extends Mock implements Callable<T, U, V> {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockFirebasePlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {}

class MockFirebaseAppPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebaseAppPlatform {}

class MockFirebaseAuthPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FirebaseAuthPlatform {}

class MockAuthStore extends Mock implements AuthStore {}

class MockBuildContext extends Mock implements BuildContext {}

class MockGoRouterState extends Mock implements GoRouterState {}

class MockAuthFailure extends Mock implements AuthFailure {}

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockAuthDatasource extends Mock implements IAuthDatasource {}

class MockErrorHandler extends Mock implements IErrorHandler {}

class MockFirebaseUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthCredential extends Mock implements AuthCredential {}

class MockGetCurrentUser extends Mock implements IGetCurrentUser {}

class MockDoLogin extends Mock implements IDoLogin {}

class MockDoLogout extends Mock implements IDoLogout {}

class MockGoRouter extends Mock implements GoRouter {}

class MockSnackbarHelper extends Mock implements SnackbarHelper {}

class MockAutoInjector extends Mock implements AutoInjector {}

class MockSentryClient extends Mock implements SentryClient {}
