import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/providers/credit_provider.dart';
import 'package:credit_manager/screens/dialogs/error_dialog.dart';
import 'package:credit_manager/screens/dialogs/success_dialog.dart';
import 'package:credit_manager/tools/financial_tool.dart';
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
              onPressed: () async {
                // If validation passes
                if (formKey.currentState!.validate()) {
                  // Read Providers
                  final creditCardProvider = context.read<CreditCardProvider>();
                  final creditProvider = context.read<CreditProvider>();

                  // Check payments
                  List<Credit> credits = await creditProvider.credits;
                  for (Credit credit in credits) {
                    //* Update credits
                    credit.payments = FinancialTool.updatePayments(
                        credit.payments, creditCard);
                    creditProvider.update(credit);
                  }

                  // * Update card on database
                  try {
                    await creditCardProvider.update(creditCard);
                    // Is insertion was successfull
                    showDialog(
                      context: context,
                      builder: (_) => const SuccessDialog(),
                    ).then((value) => Navigator.of(context)
                        .popUntil(ModalRoute.withName('/')));
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => ErrorDialog(
                        reason: e.toString(),
                      ),
                    );
                  }
                }
              })
        ], title: Text(t.screens.card_edit.page_title)),
        body: ProxyProvider0<CreditCard>(
          update: (_, __) => creditCard,
          child: CardField(formKey: formKey, enablePrimaryKey: false),
        ));
  }
}
