import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/helpers/input_formatters.dart';
import '../../../../core/helpers/snackbar_helper.dart';
import '../../../../core/injection/injector.dart';
import '../../../../core/reactivity/obs_form.dart';
import '../../../../core/router/router.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/ambient.dart';
import '../../domain/errors/failures.dart';
import '../controllers/edit_ambient_controller.dart';

enum _FormFields {
  name,
  host,
  port,
  username,
  password,
  temperatureTopic,
  humidityTopic,
  airConditionerStatusTopic,
  setAirConditionerStatusTopic,
}

class EditAmbientPage extends StatefulWidget {
  final String? ambientId;

  const EditAmbientPage(this.ambientId, {super.key});

  @override
  State<EditAmbientPage> createState() => _EditAmbientPageState();
}

class _EditAmbientPageState extends State<EditAmbientPage> {
  final reactionDisposers = <ReactionDisposer>[];
  final controller = inject<EditAmbientController>();
  final formState = ObservableForm(_FormFields.values);

  @override
  void initState() {
    reactionDisposers.addAll([
      reaction((_) => controller.failure, _onFailure),
      reaction((_) => controller.success, _onSuccess),
      reaction((_) => controller.ambient, _onLoadAmbient),
    ]);
    controller.fetchAmbient(widget.ambientId);
    super.initState();
  }

  @override
  void dispose() {
    for (final dispose in reactionDisposers) {
      dispose();
    }
    super.dispose();
  }

  Future<void> _onLoadAmbient(Ambient? ambient) async {
    if (ambient != null) {
      formState.setFieldValues({
        _FormFields.name: ambient.name,
        _FormFields.host: ambient.host,
        _FormFields.port: ambient.port.toString(),
        _FormFields.username: ambient.username,
        _FormFields.password: ambient.password,
        _FormFields.temperatureTopic: ambient.topics.temperature,
        _FormFields.humidityTopic: ambient.topics.humidity,
        _FormFields.airConditionerStatusTopic:
            ambient.topics.airConditionerStatus,
        _FormFields.setAirConditionerStatusTopic:
            ambient.topics.setAirConditionerStatus,
      });
    }
  }

  void _onSuccess(SuccessfulAction? action) {
    if (action == SuccessfulAction.save) {
      context.showSuccessSnackbar('Ambiente salvo com sucesso.');
      _onNavigateBack();
    } else if (action == SuccessfulAction.delete) {
      context.showSuccessSnackbar('Ambiente excluído com sucesso.');
      _onNavigateBack();
    }
  }

  void _onFailure(AppFailure? failure) {
    if (failure != null) {
      context.showErrorSnackbar(failure.message);
      if (failure is AmbientNotFound) {
        _onNavigateBack();
      }
    }
  }

  void _onNavigateBack() {
    context.navigateTo('/');
  }

  void _onSave() {
    controller.saveAmbient(widget.ambientId, formState.getValues());
  }

  void _onDelete() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: 'Excluir ambiente?',
        content: 'Deseja realmente excluir este ambiente? '
            'Esta ação é irreversível.',
        onYes: _onConfirmDelete,
      ),
    );
  }

  void _onConfirmDelete() {
    if (widget.ambientId != null) {
      controller.deleteAmbient(widget.ambientId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Observer(
      builder: (_) {
        final isSavingOrDeleting = controller.isSavingOrDeleting;
        final isFetching = controller.isFetching;

        final isDisabled = isSavingOrDeleting || isFetching;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.ambientId == null
                  ? 'Adicionar Ambiente'
                  : 'Editar Ambiente',
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: _onNavigateBack,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            actions: [
              if (widget.ambientId != null)
                IconButton(
                  onPressed: isDisabled ? null : _onDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              IconButton(
                onPressed: isDisabled ? null : _onSave,
                icon: const Icon(Icons.check_rounded),
              ),
            ],
          ),
          body: Builder(
            builder: (_) {
              if (isFetching) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller:
                                formState.getController(_FormFields.name),
                            label: 'Nome do Ambiente',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          child: Text(
                            'Configurações do Broker',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDisabled ? colorScheme.outline : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller:
                                formState.getController(_FormFields.host),
                            label: 'Host',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller:
                                formState.getController(_FormFields.port),
                            label: 'Porta',
                            formatters: [InputFormatters.digitsOnly],
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller:
                                formState.getController(_FormFields.username),
                            label: 'Usuário',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: PasswordInput(
                            controller:
                                formState.getController(_FormFields.password),
                            label: 'Senha',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          child: Text(
                            'Tópicos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDisabled ? colorScheme.outline : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller: formState
                                .getController(_FormFields.temperatureTopic),
                            label: 'Temperatura',
                            placeholder: 'temperature',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller: formState
                                .getController(_FormFields.humidityTopic),
                            label: 'Umidade',
                            placeholder: 'humidity',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller: formState.getController(
                              _FormFields.airConditionerStatusTopic,
                            ),
                            label: 'Status do Ar Condicionado',
                            placeholder: 'airConditionerStatus',
                            isEnabled: !isDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextInput(
                            controller: formState.getController(
                              _FormFields.setAirConditionerStatusTopic,
                            ),
                            label: 'Alterar Status do Ar Condicionado',
                            placeholder: 'setAirConditionerStatus',
                            isEnabled: !isDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
