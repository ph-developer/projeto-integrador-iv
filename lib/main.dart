import 'package:flutter/material.dart';

import 'core/boot/boot.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boot.run(
    () => runApp(
      MaterialApp.router(
        title: 'Projeto Integrador IV - UNIVESP',
        themeMode: ThemeMode.light,
        theme: currentTheme,
        routerConfig: router,
      ),
    ),
  );
}
