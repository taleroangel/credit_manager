import 'package:credit_manager/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(t.dialogs.success_title),
        content: Text(t.dialogs.success_subtitle),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.app.accept))
        ],
      );
}
