import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'mobile/base_mobile_snackbar.dart';
import 'web/base_web_snackbar.dart';

class ErrorSnackbar extends StatelessWidget {
  final String message;
  final Duration duration;

  const ErrorSnackbar({
    super.key,
    required this.message,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return BaseWebSnackbar(
        message: message,
        duration: duration,
        backgroundColor: Theme.of(context).colorScheme.error,
        progressBarColor: Theme.of(context).colorScheme.errorContainer,
        textColor: Theme.of(context).colorScheme.onError,
        icon: Icons.warning_amber_rounded,
      );
    }

    return BaseMobileSnackbar(
      message: message,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.error,
      progressBarColor: Theme.of(context).colorScheme.errorContainer,
      textColor: Theme.of(context).colorScheme.onError,
      icon: Icons.warning_amber_rounded,
    );
  }
}
