import 'package:sentry_flutter/sentry_flutter.dart';

import 'error_handler.dart';

class ErrorHandlerImpl implements IErrorHandler {
  @override
  Future<void> reportException(Object exception, StackTrace? stackTrace) async {
    print(exception);
    print(stackTrace);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
