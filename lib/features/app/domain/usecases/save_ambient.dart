import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../entities/ambient.dart';
import '../errors/failures.dart';
import '../repositories/ambient_repository.dart';

abstract class ISaveAmbient {
  AsyncResult<Ambient, AppFailure> call(
    String? id,
    String name,
    String host,
    String port,
    String username,
    String password,
    String temperatureTopic,
    String humidityTopic,
    String airConditionerStatusTopic,
    String setAirConditionerStatusTopic,
  );
}

class SaveAmbientImpl implements ISaveAmbient {
  final IAmbientRepository _ambientRepository;

  SaveAmbientImpl(this._ambientRepository);

  @override
  AsyncResult<Ambient, AppFailure> call(
    String? id,
    String name,
    String host,
    String port,
    String username,
    String password,
    String temperatureTopic,
    String humidityTopic,
    String airConditionerStatusTopic,
    String setAirConditionerStatusTopic,
  ) async {
    if (name.isEmpty) {
      return const Failure(
        InvalidInput('O campo "nome" deve ser preenchido.'),
      );
    }

    if (host.isEmpty) {
      return const Failure(
        InvalidInput('O campo "host" deve ser preenchido.'),
      );
    }

    if (port.isEmpty) {
      return const Failure(
        InvalidInput('O campo "porta" deve ser preenchido.'),
      );
    }

    if (int.tryParse(port) == null) {
      return const Failure(
        InvalidInput('O campo "porta" deve deve conter apenas números.'),
      );
    }

    if (username.isEmpty) {
      return const Failure(
        InvalidInput('O campo "usuário" deve ser preenchido.'),
      );
    }

    if (password.isEmpty) {
      return const Failure(
        InvalidInput('O campo "senha" deve ser preenchido.'),
      );
    }

    return _ambientRepository.saveAmbient(
      (id == null || id.isEmpty) ? const Uuid().v4() : id,
      name,
      host,
      int.parse(port),
      username,
      password,
      temperatureTopic.isEmpty ? 'temperature' : temperatureTopic,
      humidityTopic.isEmpty ? 'humidity' : humidityTopic,
      airConditionerStatusTopic.isEmpty
          ? 'airConditionerStatus'
          : airConditionerStatusTopic,
      setAirConditionerStatusTopic.isEmpty
          ? 'setAirConditionerStatus'
          : setAirConditionerStatusTopic,
    );
  }
}
