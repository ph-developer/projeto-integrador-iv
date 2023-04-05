import 'package:auto_injector/auto_injector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../features/app/domain/repositories/ambient_repository.dart';
import '../../features/app/domain/usecases/close_ambient.dart';
import '../../features/app/domain/usecases/delete_ambient.dart';
import '../../features/app/domain/usecases/get_ambient_by_id.dart';
import '../../features/app/domain/usecases/get_ambient_sensors.dart';
import '../../features/app/domain/usecases/get_ambients.dart';
import '../../features/app/domain/usecases/save_ambient.dart';
import '../../features/app/domain/usecases/set_air_conditioner_status.dart';
import '../../features/app/external/datasources/access_datasource_impl.dart';
import '../../features/app/external/datasources/ambient_datasource_impl.dart';
import '../../features/app/external/datasources/iot_datasource_impl.dart';
import '../../features/app/infra/datasources/access_datasource.dart';
import '../../features/app/infra/datasources/ambient_datasource.dart';
import '../../features/app/infra/datasources/iot_datasource.dart';
import '../../features/app/infra/repositories/ambient_repository_impl.dart';
import '../../features/app/presentation/controllers/ambient_controller.dart';
import '../../features/app/presentation/controllers/ambients_controller.dart';
import '../../features/app/presentation/controllers/edit_ambient_controller.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/do_login.dart';
import '../../features/auth/domain/usecases/do_logout.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/external/datasources/auth_datasource_impl.dart';
import '../../features/auth/infra/datasources/auth_datasource.dart';
import '../../features/auth/infra/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/stores/auth_store.dart';
import '../errors/error_handler.dart';
import '../errors/error_handler_impl.dart';
import '../mqtt/mqtt5_broker_impl.dart';
import '../mqtt/mqtt_broker.dart';

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
  await _injectApp(_injector);

  _injector.commit();
}

Future<void> _injectCore(Injector injector) async {
  injector
    //! Firebase
    ..addInstance<FirebaseAuth>(FirebaseAuth.instance)
    ..addInstance<FirebaseFirestore>(FirebaseFirestore.instance)

    //! Core
    ..addInstance<IMqttBroker>(Mqtt5Broker())
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

Future<void> _injectApp(Injector injector) async {
  injector
    //! Datasources
    ..add<IAmbientDatasource>(AmbientDatasourceImpl.new)
    ..add<IAccessDatasource>(AccessDatasourceImpl.new)
    ..add<IIotDatasource>(IotDatasourceImpl.new)

    //! Repositories
    ..add<IAmbientRepository>(AmbientRepositoryImpl.new)

    //! Usecases
    ..add<IGetAmbientById>(GetAmbientByIdImpl.new)
    ..add<ISaveAmbient>(SaveAmbientImpl.new)
    ..add<IDeleteAmbient>(DeleteAmbientImpl.new)
    ..add<ICloseAmbient>(CloseAmbientImpl.new)
    ..add<IGetAmbients>(GetAmbientsImpl.new)
    ..add<IGetAmbientSensors>(GetAmbientSensorsImpl.new)
    ..add<ISetAirConditionerStatus>(SetAirConditionerStatusImpl.new)

    //! Controllers
    ..add<AmbientsController>(AmbientsController.new)
    ..add<AmbientController>(AmbientController.new)
    ..add<EditAmbientController>(EditAmbientController.new);
}
