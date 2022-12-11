import 'package:credit_manager/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, this.reason});
  final String? reason;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(t.dialogs.error_title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(t.dialogs.error_subtitle),
            Text(
              reason ?? t.dialogs.error_unspecified,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.app.accept))
        ],
      );
}
