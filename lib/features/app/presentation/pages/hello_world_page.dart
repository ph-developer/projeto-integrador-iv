import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/injection/injector.dart';
import '../stores/ambient_store.dart';

class HelloWorldPage extends StatefulWidget {
  const HelloWorldPage({super.key});

  @override
  State<HelloWorldPage> createState() => _HelloWorldPageState();
}

class _HelloWorldPageState extends State<HelloWorldPage> {
  final ambientStore = inject<AmbientStore>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            final ambientName = ambientStore.ambientName;

            return Text(ambientName);
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('TODO: settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Icon(Icons.thermostat_rounded),
                    Observer(
                      builder: (_) {
                        final temperature = ambientStore.temperature;

                        return Text('${temperature.toStringAsFixed(1)} °C');
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.water_drop_outlined),
                    Observer(
                      builder: (_) {
                        final humidity = ambientStore.humidity;

                        return Text('${humidity.toStringAsFixed(1)} %');
                      },
                    ),
                  ],
                )
              ],
            ),
            Center(
              heightFactor: 2.5,
              child: Observer(
                builder: (_) {
                  final isLoading = ambientStore.isLoading;
                  final isOn = ambientStore.isAirConditionerOn;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: isLoading
                            ? null
                            : ambientStore.toggleAirConditionerStatus,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 200),
                          shape: const CircleBorder(),
                          elevation: isOn && !isLoading ? 10 : 0,
                          side: BorderSide(
                            width: isOn && !isLoading ? 1.5 : 1,
                            color: isOn && !isLoading
                                ? colorScheme.tertiary
                                : colorScheme.outline,
                          ),
                          backgroundColor: colorScheme.background,
                          shadowColor: isOn && !isLoading
                              ? colorScheme.tertiary
                              : colorScheme.outline,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: isLoading
                              ? [
                                  CircularProgressIndicator(
                                    color: colorScheme.outline,
                                  ),
                                ]
                              : [
                                  Icon(
                                    Icons.power_settings_new_rounded,
                                    color: isOn
                                        ? colorScheme.tertiary
                                        : colorScheme.outline,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Ar Condicionado',
                                    style: TextStyle(
                                      fontWeight: isOn ? FontWeight.bold : null,
                                      color: isOn
                                          ? colorScheme.tertiary
                                          : colorScheme.outline,
                                    ),
                                  ),
                                  Text(
                                    isOn ? 'Ligado' : 'Desligado',
                                    style: TextStyle(
                                      fontWeight: isOn ? FontWeight.bold : null,
                                      color: isOn
                                          ? colorScheme.tertiary
                                          : colorScheme.outline,
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Observer(
                  builder: (_) {
                    if (!ambientStore.isRecomendatedTurnAirConditionerOn) {
                      return const SizedBox.shrink();
                    }

                    return Card(
                      color: colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Considerando a temperatura e umidade atual do '
                          'ambiente, recomendamos que o ar condicionado seja '
                          'ligado.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
