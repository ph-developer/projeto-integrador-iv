import '../../../../core/errors/failure.dart';

abstract class AppFailure extends Failure {
  const AppFailure(super.message);
}

class InvalidInput extends AppFailure {
  const InvalidInput(super.message);
}

class UserUnauthenticated extends AppFailure {
  const UserUnauthenticated() : super('Usuário não autenticado.');
}

class AmbientNotFound extends AppFailure {
  const AmbientNotFound() : super('Ambiente inexistente.');
}

class AmbientConnectionFailure extends AppFailure {
  const AmbientConnectionFailure()
      : super(
          'Ocorreu um erro na conexão com o ambiente.',
        );
}

class UnknownError extends AppFailure {
  const UnknownError() : super('Ocorreu um erro desconhecido.');
}
