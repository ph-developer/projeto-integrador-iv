import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/helpers/snackbar_helper.dart';
import '../../../../core/injection/injector.dart';
import '../../../../core/router/router.dart';
import '../../../auth/domain/entities/logged_user.dart';
import '../../../auth/presentation/stores/auth_store.dart';
import '../stores/ambients_store.dart';

class AmbientsPage extends StatefulWidget {
  const AmbientsPage({super.key});

  @override
  State<AmbientsPage> createState() => _AmbientsPageState();
}

class _AmbientsPageState extends State<AmbientsPage> {
  final reactionDisposers = <ReactionDisposer>[];
  final authStore = inject<AuthStore>();
  final ambientsStore = inject<AmbientsStore>();

  @override
  void initState() {
    super.initState();
    reactionDisposers.addAll([
      reaction((_) => ambientsStore.failure, _onFailure),
      reaction((_) => authStore.failure, _onFailure),
      reaction((_) => authStore.loggedUser, _onLoggedOut),
    ]);
    ambientsStore.fetchAmbients();
  }

  @override
  void dispose() {
    for (final dispose in reactionDisposers) {
      dispose();
    }
    super.dispose();
  }

  Future<void> _onFailure(Failure? failure) async {
    if (failure != null) {
      context.showErrorSnackbar(failure.message);
    }
  }

  Future<void> _onSelect(String ambientId) async {
    await context.navigateTo('/ambient/$ambientId', replace: false);
  }

  Future<void> _onLogout([dynamic _]) async {
    await authStore.doLogout();
  }

  Future<void> _onLoggedOut(LoggedUser? loggedUser) async {
    if (loggedUser == null) {
      await context.navigateTo('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambientes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: _onLogout,
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          final isFetching = ambientsStore.isFetching;
          final ambients = ambientsStore.ambients;

          if (isFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: ambients.length,
            itemBuilder: (context, index) {
              final ambient = ambients[index];

              return ListTile(
                title: Text(ambient.name),
                onTap: () => _onSelect(ambient.id),
              );
            },
          );
        },
      ),
    );
  }
}
