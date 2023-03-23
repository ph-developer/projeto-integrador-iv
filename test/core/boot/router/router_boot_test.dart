import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador_iv/core/boot/router/router_boot.dart';

void main() {
  group('run', () {
    test(
      'should setup router without errors.',
      () async {
        // act
        await RouterBoot.run();
      },
    );
  });
}
