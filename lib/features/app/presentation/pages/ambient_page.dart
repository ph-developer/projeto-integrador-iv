import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/helpers/snackbar_helper.dart';
import '../../../../core/injection/injector.dart';
import '../../../../core/router/router.dart';
import '../../domain/errors/failures.dart';
import '../controllers/ambient_controller.dart';

class AmbientPage extends StatefulWidget {
  final String ambientId;

  const AmbientPage(this.ambientId, {super.key});

  @override
  State<AmbientPage> createState() => _AmbientPageState();
}

class _AmbientPageState extends State<AmbientPage> {
  final reactionDisposers = <ReactionDisposer>[];
  final controller = inject<AmbientController>();

  @override
  void initState() {
    super.initState();
    reactionDisposers.addAll([
      reaction((_) => controller.failure, _onFailure),
    ]);
    controller.fetchAmbient(widget.ambientId);
  }

  @override
  void dispose() {
    controller.closeAmbient();
    for (final dispose in reactionDisposers) {
      dispose();
    }
    super.dispose();
  }

  void _onFailure(AppFailure? failure) {
    if (failure != null) {
      context.showErrorSnackbar(failure.message);
      if (failure is AmbientConnectionFailure) {
        _onNavigateBack();
      }
    }
  }

  void _onNavigateBack() {
    context.navigateTo('/');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            final ambientName = controller.ambient?.name ?? 'Carregando...';

            return Text(ambientName);
          },
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: _onNavigateBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Observer(
        builder: (_) {
          final isFetching = controller.isFetching;
          final ambient = controller.ambient;
          final sensors = controller.sensors;

          if (isFetching || ambient == null || sensors == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.thermostat_rounded),
                        StreamBuilder(
                          stream: sensors.temperature,
                          initialData: double.nan,
                          builder: (context, snapshot) {
                            final temperature = snapshot.data ?? double.nan;

                            return Text('${temperature.toStringAsFixed(1)} °C');
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.water_drop_outlined),
                        StreamBuilder(
                          stream: sensors.humidity,
                          builder: (context, snapshot) {
                            final humidity = snapshot.data ?? double.nan;

                            return Text('${humidity.toStringAsFixed(1)} %');
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Center(
                  heightFactor: 2.5,
                  child: StreamBuilder(
                    stream: sensors.airConditionerStatus,
                    builder: (context, snapshot) {
                      final isOn = snapshot.data ?? false;
                      final isLoading =
                          controller.isChangingAirConditionerStatus;

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () => controller.setAirConditionerStatus(
                                      on: !isOn,
                                    ),
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
                                          fontWeight:
                                              isOn ? FontWeight.bold : null,
                                          color: isOn
                                              ? colorScheme.tertiary
                                              : colorScheme.outline,
                                        ),
                                      ),
                                      Text(
                                        isOn ? 'Ligado' : 'Desligado',
                                        style: TextStyle(
                                          fontWeight:
                                              isOn ? FontWeight.bold : null,
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
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Observer(
                //       builder: (_) {
                //         if (!ambientStore.isRecomendatedTurnAirConditionerOn)
                // {
                //           return const SizedBox.shrink();
                //         }

                //         return Card(
                //           color: colorScheme.primaryContainer,
                //           child: Padding(
                //             padding: const EdgeInsets.all(16),
                //             child: Text(
                //               'Considerando a temperatura e umidade atual '
                //'do '
                //               'ambiente, recomendamos que o ar condicionado'
                //' seja '
                //               'ligado.',
                //               textAlign: TextAlign.justify,
                //               style: TextStyle(
                //                 color: Theme.of(context)
                //                     .colorScheme
                //                     .onPrimaryContainer,
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
