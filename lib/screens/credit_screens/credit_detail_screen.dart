import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/providers/credit_provider.dart';
import 'package:credit_manager/widgets/credit_installments_widget.dart';
import 'package:credit_manager/widgets/credit_widget.dart';
import 'package:credit_manager/widgets/dialogs/erase_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreditDetailScreen extends StatelessWidget {
  const CreditDetailScreen({required this.credit, super.key});
  final Credit credit;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(t.screens.credit_detail.page_title),
        actions: [
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => EraseConfirmationDialog(
                    name: t.financial.credit,
                    onDelete: () {
                      context.read<CreditProvider>().delete(credit);
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    }),
              );
            },
            icon: const Icon(Icons.delete),
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error),
            label: Text(t.app.erase.toUpperCase()),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: AbsorbPointer(child: CreditWidget(credit: credit)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text.rich(TextSpan(children: [
              const WidgetSpan(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Icon(Icons.info),
              )),
              TextSpan(
                text: "\n${t.screens.credit_detail.tutorial}",
              )
            ])),
          ),
          CreditInstallmentsWidget(
            credit: credit,
            additionalOptions: true,
          )
        ],
      ));
}
