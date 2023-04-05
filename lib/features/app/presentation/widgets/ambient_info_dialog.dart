import 'package:flutter/material.dart';

import '../../../../core/router/router.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/ambient.dart';

class AmbientInfoDialog extends StatefulWidget {
  final Ambient ambient;
  final String connectionStatus;

  const AmbientInfoDialog({
    required this.ambient,
    required this.connectionStatus,
    super.key,
  });

  @override
  State<AmbientInfoDialog> createState() => _AmbientInfoDialogState();
}

class _AmbientInfoDialogState extends State<AmbientInfoDialog> {
  void _editAmbient() {
    context.navigateTo('/edit-ambient/${widget.ambient.id}');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.ambient.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Host: ${widget.ambient.host}:${widget.ambient.port}'),
          Text('Usuário: ${widget.ambient.username}'),
          Text('Status: ${widget.connectionStatus}'),
        ],
      ),
      actions: [
        OutlineButton(
          type: ButtonType.primary,
          onPressed: _editAmbient,
          icon: Icons.edit_note_rounded,
          label: 'Editar',
        )
      ],
    );
  }
}
