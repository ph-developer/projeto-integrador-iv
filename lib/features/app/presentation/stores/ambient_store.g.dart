// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambient_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AmbientStore on _AmbientStoreBase, Store {
  Computed<bool>? _$isRecomendatedTurnAirConditionerOnComputed;

  @override
  bool get isRecomendatedTurnAirConditionerOn =>
      (_$isRecomendatedTurnAirConditionerOnComputed ??= Computed<bool>(
              () => super.isRecomendatedTurnAirConditionerOn,
              name: '_AmbientStoreBase.isRecomendatedTurnAirConditionerOn'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_AmbientStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$ambientNameAtom =
      Atom(name: '_AmbientStoreBase.ambientName', context: context);

  @override
  String get ambientName {
    _$ambientNameAtom.reportRead();
    return super.ambientName;
  }

  @override
  set ambientName(String value) {
    _$ambientNameAtom.reportWrite(value, super.ambientName, () {
      super.ambientName = value;
    });
  }

  late final _$temperatureAtom =
      Atom(name: '_AmbientStoreBase.temperature', context: context);

  @override
  double get temperature {
    _$temperatureAtom.reportRead();
    return super.temperature;
  }

  @override
  set temperature(double value) {
    _$temperatureAtom.reportWrite(value, super.temperature, () {
      super.temperature = value;
    });
  }

  late final _$humidityAtom =
      Atom(name: '_AmbientStoreBase.humidity', context: context);

  @override
  double get humidity {
    _$humidityAtom.reportRead();
    return super.humidity;
  }

  @override
  set humidity(double value) {
    _$humidityAtom.reportWrite(value, super.humidity, () {
      super.humidity = value;
    });
  }

  late final _$isAirConditionerOnAtom =
      Atom(name: '_AmbientStoreBase.isAirConditionerOn', context: context);

  @override
  bool get isAirConditionerOn {
    _$isAirConditionerOnAtom.reportRead();
    return super.isAirConditionerOn;
  }

  @override
  set isAirConditionerOn(bool value) {
    _$isAirConditionerOnAtom.reportWrite(value, super.isAirConditionerOn, () {
      super.isAirConditionerOn = value;
    });
  }

  late final _$_isRecomendatedTurnAirConditionerOnAtom = Atom(
      name: '_AmbientStoreBase._isRecomendatedTurnAirConditionerOn',
      context: context);

  @override
  bool get _isRecomendatedTurnAirConditionerOn {
    _$_isRecomendatedTurnAirConditionerOnAtom.reportRead();
    return super._isRecomendatedTurnAirConditionerOn;
  }

  @override
  set _isRecomendatedTurnAirConditionerOn(bool value) {
    _$_isRecomendatedTurnAirConditionerOnAtom
        .reportWrite(value, super._isRecomendatedTurnAirConditionerOn, () {
      super._isRecomendatedTurnAirConditionerOn = value;
    });
  }

  late final _$toggleAirConditionerStatusAsyncAction = AsyncAction(
      '_AmbientStoreBase.toggleAirConditionerStatus',
      context: context);

  @override
  Future<void> toggleAirConditionerStatus() {
    return _$toggleAirConditionerStatusAsyncAction
        .run(() => super.toggleAirConditionerStatus());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
ambientName: ${ambientName},
temperature: ${temperature},
humidity: ${humidity},
isAirConditionerOn: ${isAirConditionerOn},
isRecomendatedTurnAirConditionerOn: ${isRecomendatedTurnAirConditionerOn}
    ''';
  }
}
