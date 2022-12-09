import 'dart:math';
import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/tools/financial_tool.dart';
import 'package:credit_manager/widgets/credit_installments_widget.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  // Form
  final _formKey = GlobalKey<FormState>();
  final _loanController = TextEditingController();
  final _interestController = TextEditingController();
  final _installmentsController = TextEditingController();
  final _othersController = TextEditingController();

  // Credit
  Credit? credit;
  Iterable<double>? creditValues;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(padding: const EdgeInsets.all(16.0), children: [
        TextFormField(
            controller: _loanController,
            validator: requiredField,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]|\."))
            ],
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: t.financial.loan)),
        const SizedBox(height: 16.0),
        TextFormField(
            validator: requiredField,
            controller: _interestController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]|\."))
            ],
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: t.financial.interest)),
        const SizedBox(height: 16.0),
        TextFormField(
            validator: requiredField,
            controller: _installmentsController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
            ],
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: t.financial.term)),
        const SizedBox(height: 16.0),
        TextFormField(
            controller: _othersController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
            ],
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "${t.financial.others} ${t.app.optional}")),
        const SizedBox(height: 16.0),
        ElevatedButton.icon(
          icon: const Icon(Icons.calculate),
          label: Text(t.screens.credit_screen.calculate),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            // Obtain variables
            final loan = Decimal.parse(_loanController.text);
            final interest = Decimal.parse(_interestController.text);
            final installments = int.parse(_installmentsController.text);
            final others = Decimal.tryParse(_othersController.text);

            // Payment information
            final payments = FinancialTool.calculateCredit(
                debt: loan,
                installments: installments,
                interest: interest,
                others: others);

            // Create the credit
            setState(() {
              credit = Credit(
                  loan: loan,
                  interest: interest,
                  installments: installments,
                  payments: payments);
              creditValues = credit!.payments.map((e) => e.total.toDouble());
            });
          },
        ),
        if (credit != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              children: [
                Text(t.screens.credit_screen.credit_summary),
                const Divider(),
                Text.rich(
                    TextSpan(children: [
                      // Show Total
                      TextSpan(
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).colorScheme.primary),
                          children: [
                            TextSpan(
                                text: t.screens.credit_screen.total,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                //* Calculate MAX Payment
                                text: FinancialTool.formatCurrency(
                                    context,
                                    creditValues!.reduce(
                                        (value, element) => (value + element))))
                          ]),
                      // Show maximum
                      TextSpan(children: [
                        TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text:
                                "\n${t.screens.credit_screen.max_installment}"),
                        TextSpan(
                            text: FinancialTool.formatCurrency(
                                context, creditValues!.reduce(max)))
                      ])
                    ]),
                    textAlign: TextAlign.center),
                //* Save in Credit Card
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => _SaveCredit(credit: credit!)),
                      icon: const Icon(Icons.save),
                      label:
                          Text(t.screens.credit_screen.store_on_credit_card)),
                ),
                const Divider(),
                CreditInstallmentsWidget(credit: credit!)
              ],
            ),
          ),
      ]),
    );
  }

  String? requiredField(value) {
    if (value == null || value.isEmpty) {
      return t.app.required;
    }
    final val = double.tryParse(value);
    if (val == null || val < 0.0) {
      return t.app.invalid;
    }
    return null;
  }
}

class _SaveCredit extends StatefulWidget {
  const _SaveCredit({super.key, required this.credit});
  final Credit credit;

  @override
  State<_SaveCredit> createState() => _SaveCreditState();
}

class _SaveCreditState extends State<_SaveCredit> {
  bool canSave = false;

  @override
  Widget build(BuildContext context) {
    final cardProivder = context.read<CreditCardProvider>();
    return AlertDialog(
      title: Text(t.screens.credit_screen.store_on_credit_card),
      content: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: t.models.credit.name),
          ),
          FutureBuilder(
            future: cardProivder.creditCards,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(t.screens.cards.no_cards),
                  );
                } else {
                  return DropdownButton(
                    onChanged: null,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e.name,
                              child: Text(e.name),
                            ))
                        .toList(),
                  );
                }
              }
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      )),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.app.cancel))
      ],
    );
  }
}
