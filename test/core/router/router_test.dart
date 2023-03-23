import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador_iv/core/router/router.dart';

void main() {
  group('setupRouter', () {
    test(
      'should setup router without errors.',
      () async {
        // act
        await setupRouter();
        // assert
        expect(router, isA<Router>());
      },
    );
  });
}
