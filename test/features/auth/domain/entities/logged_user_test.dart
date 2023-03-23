import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador_iv/features/auth/domain/entities/logged_user.dart';

void main() {
  test(
    'should return true when all props are equals.',
    () async {
      // arrange
      const tUserA = LoggedUser(id: 'id', email: 'email');
      const tUserB = LoggedUser(id: 'id', email: 'email');
      // act
      final result = tUserA == tUserB;
      // assert
      expect(result, isTrue);
    },
  );

  test(
    'should return false when any prop are different.',
    () async {
      // arrange
      const tUserA = LoggedUser(id: 'id', email: 'email1');
      const tUserB = LoggedUser(id: 'id', email: 'email2');
      // act
      final result = tUserA == tUserB;
      // assert
      expect(result, isFalse);
    },
  );
}
