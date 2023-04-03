// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambients_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AmbientsStore on _AmbientsStoreBase, Store {
  late final _$isFetchingAtom =
      Atom(name: '_AmbientsStoreBase.isFetching', context: context);

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

  late final _$ambientsAtom =
      Atom(name: '_AmbientsStoreBase.ambients', context: context);

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
      Atom(name: '_AmbientsStoreBase.failure', context: context);

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
      AsyncAction('_AmbientsStoreBase.fetchAmbients', context: context);

  @override
  Future<void> fetchAmbients() {
    return _$fetchAmbientsAsyncAction.run(() => super.fetchAmbients());
  }

  @override
  String toString() {
    return '''
isFetching: ${isFetching},
ambients: ${ambients},
failure: ${failure}
    ''';
  }
}
