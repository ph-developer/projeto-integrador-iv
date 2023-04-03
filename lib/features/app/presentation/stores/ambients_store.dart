// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../../domain/entities/ambient.dart';
import '../../domain/errors/failures.dart';
import '../../domain/usecases/get_ambients.dart';

part 'ambients_store.g.dart';

class AmbientsStore = _AmbientsStoreBase with _$AmbientsStore;

abstract class _AmbientsStoreBase with Store {
  final IGetAmbients _getAmbients;

  _AmbientsStoreBase(
    this._getAmbients,
  );

  @observable
  bool isFetching = false;

  @observable
  ObservableList<Ambient> ambients = ObservableList.of([]);

  @observable
  AppFailure? failure;

  @action
  Future<void> fetchAmbients() async {
    isFetching = true;
    ambients.clear();

    final result = await _getAmbients();

    result.fold(
      ambients.addAll,
      (failure) => this.failure = failure,
    );

    isFetching = false;
  }
}
