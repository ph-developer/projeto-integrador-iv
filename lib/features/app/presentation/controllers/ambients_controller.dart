// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../../domain/entities/ambient.dart';
import '../../domain/errors/failures.dart';
import '../../domain/usecases/get_ambients.dart';

part 'ambients_controller.g.dart';

class AmbientsController = _AmbientsControllerBase with _$AmbientsController;

abstract class _AmbientsControllerBase with Store {
  final IGetAmbients _getAmbients;

  _AmbientsControllerBase(
    this._getAmbients,
  );

  @observable
  bool isFetching = false;

  @observable
  bool isAdding = false;

  @observable
  bool isRemoving = false;

  @observable
  ObservableList<Ambient> ambients = ObservableList.of([]);

  @observable
  AppFailure? failure;

  @action
  Future<void> fetchAmbients() async {
    if (isFetching) return;

    isFetching = true;
    failure = null;
    ambients.clear();

    final result = await _getAmbients();

    result.fold(
      ambients.addAll,
      (failure) => this.failure = failure,
    );

    isFetching = false;
  }
}
