import 'dart:developer';

import 'package:credit_manager/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            builder: (context, snapshot) => CircularProgressIndicator(),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.balance),
            label: Text(t.app.licenses),
            onPressed: () {
              showLicensePage(context: context);
            },
          )
        ],
      ));
}
