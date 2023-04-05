import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/ambient.dart';
import 'ambient_info_dialog.dart';

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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
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
    if (isLoading) return;

    try {
      setState(() {
        isLoading = true;
      });
      await Socket.connect(
        widget.ambient.host,
        widget.ambient.port,
        timeout: const Duration(seconds: 5),
      );
      setState(() {
        _connectionStatus = _ConnectionStatus.online;
        isLoading = false;
      });
    } catch (e) {
      try {
        setState(() {
          _connectionStatus = _ConnectionStatus.offline;
          isLoading = false;
        });
      } catch (_) {}
    }
  }

  void _showInfoModal(BuildContext context) {
    var connectionStatus = 'Carregando...';

    if (_connectionStatus == _ConnectionStatus.online) {
      connectionStatus = 'Online';
    } else if (_connectionStatus == _ConnectionStatus.offline) {
      connectionStatus = 'Offline';
    }

    showDialog(
      context: context,
      builder: (context) => AmbientInfoDialog(
        ambient: widget.ambient,
        connectionStatus: connectionStatus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    late Widget statusIndicator;

    if (_connectionStatus == _ConnectionStatus.online) {
      statusIndicator = Icon(
        Icons.circle_rounded,
        color: colorScheme.tertiary,
        size: 15,
      );
    } else if (_connectionStatus == _ConnectionStatus.offline) {
      statusIndicator = Icon(
        Icons.circle_outlined,
        color: colorScheme.error,
        size: 15,
      );
    } else {
      statusIndicator = Padding(
        padding: const EdgeInsets.only(right: 3),
        child: SizedBox(
          height: 12,
          width: 12,
          child: CircularProgressIndicator(
            color: colorScheme.outline,
            strokeWidth: 2,
          ),
        ),
      );
    }

    return ListTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
            child: statusIndicator,
          ),
          Text(
            widget.ambient.name,
            style: _connectionStatus == _ConnectionStatus.online
                ? null
                : TextStyle(color: colorScheme.outline),
          ),
        ],
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
