// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambient_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AmbientStore on _AmbientStoreBase, Store {
  late final _$isFetchingAtom =
      Atom(name: '_AmbientStoreBase.isFetching', context: context);

  @override
  bool get isFetching {
    _$isFetchingAtom.reportRead();
    return super.isFetching;
  }

  @override
  set isFetching(bool value) {
    _$isFetchingAtom.reportWrite(value, super.isFetching, () {
      super.isFetching = value;
    });
  }

  late final _$isChangingAirConditionerStatusAtom = Atom(
      name: '_AmbientStoreBase.isChangingAirConditionerStatus',
      context: context);

  @override
  bool get isChangingAirConditionerStatus {
    _$isChangingAirConditionerStatusAtom.reportRead();
    return super.isChangingAirConditionerStatus;
  }

  @override
  set isChangingAirConditionerStatus(bool value) {
    _$isChangingAirConditionerStatusAtom
        .reportWrite(value, super.isChangingAirConditionerStatus, () {
      super.isChangingAirConditionerStatus = value;
    });
  }

  late final _$ambientAtom =
      Atom(name: '_AmbientStoreBase.ambient', context: context);

  @override
  Ambient? get ambient {
    _$ambientAtom.reportRead();
    return super.ambient;
  }

  @override
  set ambient(Ambient? value) {
    _$ambientAtom.reportWrite(value, super.ambient, () {
      super.ambient = value;
    });
  }

  late final _$sensorsAtom =
      Atom(name: '_AmbientStoreBase.sensors', context: context);

  @override
  Sensors? get sensors {
    _$sensorsAtom.reportRead();
    return super.sensors;
  }

  @override
  set sensors(Sensors? value) {
    _$sensorsAtom.reportWrite(value, super.sensors, () {
      super.sensors = value;
    });
  }

  late final _$failureAtom =
      Atom(name: '_AmbientStoreBase.failure', context: context);

  @override
  AppFailure? get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(AppFailure? value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  late final _$fetchAmbientAsyncAction =
      AsyncAction('_AmbientStoreBase.fetchAmbient', context: context);

  @override
  Future<void> fetchAmbient(String ambientId) {
    return _$fetchAmbientAsyncAction.run(() => super.fetchAmbient(ambientId));
  }

  late final _$closeAmbientAsyncAction =
      AsyncAction('_AmbientStoreBase.closeAmbient', context: context);

  @override
  Future<void> closeAmbient() {
    return _$closeAmbientAsyncAction.run(() => super.closeAmbient());
  }

  late final _$setAirConditionerStatusAsyncAction = AsyncAction(
      '_AmbientStoreBase.setAirConditionerStatus',
      context: context);

  @override
  Future<void> setAirConditionerStatus({required bool on}) {
    return _$setAirConditionerStatusAsyncAction
        .run(() => super.setAirConditionerStatus(on: on));
  }

  @override
  String toString() {
    return '''
isFetching: ${isFetching},
isChangingAirConditionerStatus: ${isChangingAirConditionerStatus},
ambient: ${ambient},
sensors: ${sensors},
failure: ${failure}
    ''';
  }
}
