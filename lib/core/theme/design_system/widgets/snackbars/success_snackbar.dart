import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'mobile/base_mobile_snackbar.dart';
import 'web/base_web_snackbar.dart';

class SuccessSnackbar extends StatelessWidget {
  final String message;
  final Duration duration;

  const SuccessSnackbar({
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
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        progressBarColor: Theme.of(context).colorScheme.tertiaryContainer,
        textColor: Theme.of(context).colorScheme.onTertiary,
        icon: Icons.check_circle_outline_rounded,
      );
    }

    return BaseMobileSnackbar(
      message: message,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      progressBarColor: Theme.of(context).colorScheme.tertiaryContainer,
      textColor: Theme.of(context).colorScheme.onTertiary,
      icon: Icons.check_circle_outline_rounded,
    );
  }
}
