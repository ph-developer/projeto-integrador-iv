import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_integrador_iv/core/boot/sentry/sentry_boot.dart';

import '../../../mocks.dart';

void main() {
  late Callable mockCallable;

  setUp(() {
    mockCallable = MockCallable();
  });

  group('run', () {
    test(
      'should run appRunner function after init.',
      () async {
        // arrange
        final tAppRunner = mockCallable;
        // act
        await SentryBoot.run(tAppRunner);
        // assert
        verify(() => mockCallable()).called(1);
      },
    );
  });
}
