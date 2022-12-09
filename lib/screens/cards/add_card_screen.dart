import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/widgets/card_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Variables
    final formKey = GlobalKey<FormState>();
    CreditCard creditCard = CreditCard();

    // Widget build
    return Scaffold(
        appBar: AppBar(actions: [
          TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(t.app.add.toUpperCase()),
              onPressed: () {
                // If validation passes
                if (formKey.currentState!.validate()) {
                  context.read<CreditCardProvider>().insert(creditCard);
                  Navigator.of(context).pop();
                }
              })
        ], title: Text(t.screens.card_edit.page_title)),
        body: ProxyProvider0<CreditCard>(
          update: (_, __) => creditCard,
          child: CardField(formKey: formKey),
        ));
  }
}
