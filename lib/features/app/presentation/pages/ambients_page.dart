import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/helpers/snackbar_helper.dart';
import '../../../../core/injection/injector.dart';
import '../../../../core/router/router.dart';
import '../../../../core/theme/theme.dart';
import '../../../auth/domain/entities/logged_user.dart';
import '../../../auth/presentation/stores/auth_store.dart';
import '../controllers/ambients_controller.dart';
import '../widgets/ambient_tile.dart';

class AmbientsPage extends StatefulWidget {
  const AmbientsPage({super.key});

  @override
  State<AmbientsPage> createState() => _AmbientsPageState();
}

class _AmbientsPageState extends State<AmbientsPage> {
  final reactionDisposers = <ReactionDisposer>[];
  final authStore = inject<AuthStore>();
  final controller = inject<AmbientsController>();

  @override
  void initState() {
    super.initState();
    reactionDisposers.addAll([
      reaction((_) => controller.failure, _onFailure),
      reaction((_) => authStore.failure, _onFailure),
      reaction((_) => authStore.loggedUser, _onLoggedOut),
    ]);
    controller.fetchAmbients();
  }

  @override
  void dispose() {
    for (final dispose in reactionDisposers) {
      dispose();
    }
    super.dispose();
  }

  void _onFailure(Failure? failure) {
    if (failure != null) {
      context.showErrorSnackbar(failure.message);
    }
  }

  void _onSelect(String ambientId) {
    context.navigateTo('/ambient/$ambientId', replace: false);
  }

  void _onLogout([dynamic _]) {
    authStore.doLogout();
  }

  void _onLoggedOut(LoggedUser? loggedUser) {
    if (loggedUser == null) {
      context.navigateTo('/login');
    }
  }

  void _addAmbient() {
    context.navigateTo('/edit-ambient');
  }

  void _onRefresh() {
    controller.fetchAmbients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambientes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _onRefresh,
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: _onLogout,
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final isFetching = controller.isFetching;
          final ambients = controller.ambients;

          if (isFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: ambients.length + 1,
            itemBuilder: (context, index) {
              if (index == ambients.length) {
                return ListTile(
                  title: Center(
                    child: OutlineButton(
                      type: ButtonType.primary,
                      onPressed: _addAmbient,
                      label: 'Adicionar Ambiente',
                      icon: Icons.add_rounded,
                    ),
                  ),
                );
              }

              final ambient = ambients[index];

              return AmbientTile(
                ambient: ambient,
                onSelect: _onSelect,
              );
            },
          );
        },
      ),
    );
  }
}
