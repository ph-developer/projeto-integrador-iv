import 'package:flutter/material.dart';
import 'package:projeto_integrador_iv/core/helpers/snackbar_helper.dart';
import 'package:projeto_integrador_iv/core/theme/theme.dart';

class HelloWorldPage extends StatefulWidget {
  const HelloWorldPage({super.key});

  @override
  State<HelloWorldPage> createState() => _HelloWorldPageState();
}

class _HelloWorldPageState extends State<HelloWorldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlineButton(
          type: ButtonType.primary,
          onPressed: () {
            context.showSuccessSnackbar('uhul');
          },
          label: 'click',
          icon: Icons.abc,
        ),
      ),
    );
  }
}
