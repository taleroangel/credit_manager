import 'package:credit_manager/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class EraseConfirmationDialog extends StatelessWidget {
  const EraseConfirmationDialog(
      {required this.name, required this.onDelete, super.key});
  final String name;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) => AlertDialog(
        content:
            Text(t.screens.card_details.delete_confirmation(cardName: name)),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.app.cancel)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onError,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: onDelete,
            child: Text(t.app.erase),
          )
        ],
      );
}
