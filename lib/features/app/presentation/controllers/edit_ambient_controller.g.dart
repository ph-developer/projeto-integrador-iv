// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_ambient_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditAmbientController on _EditAmbientControllerBase, Store {
  late final _$isFetchingAtom =
      Atom(name: '_EditAmbientControllerBase.isFetching', context: context);

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

  late final _$isSavingOrDeletingAtom = Atom(
      name: '_EditAmbientControllerBase.isSavingOrDeleting', context: context);

  @override
  bool get isSavingOrDeleting {
    _$isSavingOrDeletingAtom.reportRead();
    return super.isSavingOrDeleting;
  }

  @override
  set isSavingOrDeleting(bool value) {
    _$isSavingOrDeletingAtom.reportWrite(value, super.isSavingOrDeleting, () {
      super.isSavingOrDeleting = value;
    });
  }

  late final _$ambientAtom =
      Atom(name: '_EditAmbientControllerBase.ambient', context: context);

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

  late final _$failureAtom =
      Atom(name: '_EditAmbientControllerBase.failure', context: context);

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

  late final _$successAtom =
      Atom(name: '_EditAmbientControllerBase.success', context: context);

  @override
  SuccessfulAction? get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(SuccessfulAction? value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$fetchAmbientAsyncAction =
      AsyncAction('_EditAmbientControllerBase.fetchAmbient', context: context);

  @override
  Future<void> fetchAmbient(String? ambientId) {
    return _$fetchAmbientAsyncAction.run(() => super.fetchAmbient(ambientId));
  }

  late final _$saveAmbientAsyncAction =
      AsyncAction('_EditAmbientControllerBase.saveAmbient', context: context);

  @override
  Future<void> saveAmbient(String? id, Map<String, String> payload) {
    return _$saveAmbientAsyncAction.run(() => super.saveAmbient(id, payload));
  }

  late final _$deleteAmbientAsyncAction =
      AsyncAction('_EditAmbientControllerBase.deleteAmbient', context: context);

  @override
  Future<void> deleteAmbient(String ambientId) {
    return _$deleteAmbientAsyncAction.run(() => super.deleteAmbient(ambientId));
  }

  @override
  String toString() {
    return '''
isFetching: ${isFetching},
isSavingOrDeleting: ${isSavingOrDeleting},
ambient: ${ambient},
failure: ${failure},
success: ${success}
    ''';
  }
}
