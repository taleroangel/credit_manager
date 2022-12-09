import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/widgets/card_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCardScreen extends StatelessWidget {
  const EditCardScreen({super.key, required this.creditCard});
  final CreditCard creditCard;

  @override
  Widget build(BuildContext context) {
    // Variables
    final formKey = GlobalKey<FormState>();
    CreditCard creditCard = this.creditCard;

    // Widget build
    return Scaffold(
        appBar: AppBar(actions: [
          TextButton.icon(
              icon: const Icon(Icons.check),
              label: Text(t.app.update.toUpperCase()),
              onPressed: () {
                // If validation passes
                if (formKey.currentState!.validate()) {
                  context.read<CreditCardProvider>().update(creditCard);
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                }
              })
        ], title: Text(t.screens.card_edit.page_title)),
        body: ProxyProvider0<CreditCard>(
          update: (_, __) => creditCard,
          child: CardField(formKey: formKey, enablePrimaryKey: false),
        ));
  }
}