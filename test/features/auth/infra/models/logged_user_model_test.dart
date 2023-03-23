import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador_iv/features/auth/domain/entities/logged_user.dart';
import 'package:projeto_integrador_iv/features/auth/infra/models/logged_user_model.dart';

void main() {
  const tUser = LoggedUserModel(id: 'id', email: 'email');
  const tUserMap = {'id': 'id', 'email': 'email'};

  test(
    'should extends LoggedUser.',
    () async {
      // assert
      expect(tUser, isA<LoggedUser>());
    },
  );

  group('fromMap', () {
    test(
      'should convert a map to a LoggedUserModel.',
      () async {
        // act
        final result = LoggedUserModel.fromMap(tUserMap);
        // assert
        expect(result, isA<LoggedUserModel>());
        expect(result, equals(tUser));
      },
    );
  });
}
