import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/ambient.dart';

enum _ConnectionStatus { online, offline, loading }

class AmbientTile extends StatefulWidget {
  final Ambient ambient;
  final Function(String)? onSelect;

  const AmbientTile({
    required this.ambient,
    required this.onSelect,
    super.key,
  });

  @override
  State<AmbientTile> createState() => _AmbientTileState();
}

class _AmbientTileState extends State<AmbientTile> {
  _ConnectionStatus _connectionStatus = _ConnectionStatus.loading;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) => _verifyConnectionStatus(),
    );
    _verifyConnectionStatus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _verifyConnectionStatus() async {
    try {
      await Socket.connect(
        widget.ambient.host,
        widget.ambient.port,
        timeout: const Duration(seconds: 5),
      );
      setState(() {
        _connectionStatus = _ConnectionStatus.online;
      });
    } catch (e) {
      setState(() {
        _connectionStatus = _ConnectionStatus.offline;
      });
    }
  }

  void _showInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        var status = 'Carregando...';

        if (_connectionStatus == _ConnectionStatus.online) {
          status = 'Online';
        } else if (_connectionStatus == _ConnectionStatus.offline) {
          status = 'Offline';
        }

        return AlertDialog(
          title: Center(child: Text(widget.ambient.name)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Host: ${widget.ambient.host}:${widget.ambient.port}'),
              Text('Usuário: ${widget.ambient.username}'),
              Text('Status: $status'),
            ],
          ),
          actions: [
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  'Excluir',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var statusColor = colorScheme.outline;
    var icon = Icons.circle_outlined;

    if (_connectionStatus == _ConnectionStatus.online) {
      statusColor = colorScheme.tertiary;
      icon = Icons.circle_rounded;
    } else if (_connectionStatus == _ConnectionStatus.offline) {
      statusColor = colorScheme.error;
    }

    return ListTile(
      leading: Icon(
        icon,
        color: statusColor,
        size: 20,
      ),
      title: Text(
        widget.ambient.name,
        style: _connectionStatus == _ConnectionStatus.online
            ? null
            : TextStyle(color: colorScheme.outline),
      ),
      trailing: IconButton(
        onPressed: () => _showInfoModal(context),
        icon: const Icon(Icons.info_outline_rounded),
      ),
      onTap: _connectionStatus == _ConnectionStatus.online
          ? () => widget.onSelect?.call(widget.ambient.id)
          : null,
    );
  }
}
