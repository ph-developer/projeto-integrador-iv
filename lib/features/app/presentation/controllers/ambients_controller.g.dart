// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambients_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AmbientsController on _AmbientsControllerBase, Store {
  late final _$isFetchingAtom =
      Atom(name: '_AmbientsControllerBase.isFetching', context: context);

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

  late final _$isAddingAtom =
      Atom(name: '_AmbientsControllerBase.isAdding', context: context);

  @override
  bool get isAdding {
    _$isAddingAtom.reportRead();
    return super.isAdding;
  }

  @override
  set isAdding(bool value) {
    _$isAddingAtom.reportWrite(value, super.isAdding, () {
      super.isAdding = value;
    });
  }

  late final _$isRemovingAtom =
      Atom(name: '_AmbientsControllerBase.isRemoving', context: context);

  @override
  bool get isRemoving {
    _$isRemovingAtom.reportRead();
    return super.isRemoving;
  }

  @override
  set isRemoving(bool value) {
    _$isRemovingAtom.reportWrite(value, super.isRemoving, () {
      super.isRemoving = value;
    });
  }

  late final _$ambientsAtom =
      Atom(name: '_AmbientsControllerBase.ambients', context: context);

  @override
  ObservableList<Ambient> get ambients {
    _$ambientsAtom.reportRead();
    return super.ambients;
  }

  @override
  set ambients(ObservableList<Ambient> value) {
    _$ambientsAtom.reportWrite(value, super.ambients, () {
      super.ambients = value;
    });
  }

  late final _$failureAtom =
      Atom(name: '_AmbientsControllerBase.failure', context: context);

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

  late final _$fetchAmbientsAsyncAction =
      AsyncAction('_AmbientsControllerBase.fetchAmbients', context: context);

  @override
  Future<void> fetchAmbients() {
    return _$fetchAmbientsAsyncAction.run(() => super.fetchAmbients());
  }

  @override
  String toString() {
    return '''
isFetching: ${isFetching},
isAdding: ${isAdding},
isRemoving: ${isRemoving},
ambients: ${ambients},
failure: ${failure}
    ''';
  }
}
