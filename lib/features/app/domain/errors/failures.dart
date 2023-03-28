import '../../../../core/errors/failure.dart';

abstract class AppFailure extends Failure {
  const AppFailure(super.message);
}

class InvalidInput extends AppFailure {
  const InvalidInput(super.message);
}

class UnknownError extends AppFailure {
  const UnknownError() : super('Ocorreu um erro desconhecido.');
}
