import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/models/payment.dart';
import 'package:credit_manager/providers/credit_provider.dart';
import 'package:credit_manager/tools/financial_tool.dart';
import 'package:credit_manager/widgets/dialogs/error_dialog.dart';
import 'package:credit_manager/widgets/dialogs/success_dialog.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreditInstallmentsWidget extends StatelessWidget {
  const CreditInstallmentsWidget(
      {super.key, required this.credit, this.additionalOptions = false});
  final Credit credit;
  final bool additionalOptions;

  @override
  Widget build(BuildContext context) {
    // This widget is dependant on Credits
    context.watch<CreditProvider>();
    // Total due calculation
    Decimal total = Decimal.zero;

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: credit.payments.length + 1,
      itemBuilder: (context, i) {
        if (i == credit.payments.length) {
          return ListTile(
            title: Text(t.screens.credit.total),
            trailing: Text(FinancialTool.formatCurrency(context, total)),
          );
        }

        // Return the item and add to total
        total += credit.payments[i].total;
        return _ListItem(
          credit: credit,
          additionalButtons: additionalOptions,
          i: i,
        );
      },
    );
  }
}

class _ListItem extends StatefulWidget {
  const _ListItem(
      {required this.credit, required this.additionalButtons, required this.i});
  final Credit credit;
  final bool additionalButtons;
  final int i;

  @override
  State<_ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<_ListItem> {
  @override
  Widget build(BuildContext context) {
    // Obtain the provider
    final creditProvider = context.watch<CreditProvider>();

    // String formatters
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat.yMd(locale.toString());

    return ListTile(
      onTap: () async {
        final retval = await showDialog(
            context: context,
            builder: (_) => _PaymentDeposit(
                  payment: widget.credit.payments[widget.i],
                ));
        if (retval != null) {
          // Update values
          widget.credit.payments[widget.i] = widget.credit.payments[widget.i]
              .copyWith(deposit: retval['deposit'], others: retval['expense']);

          // Recalculate the credit
          widget.credit.payments =
              FinancialTool.recalculateCredit(widget.credit);

          // Update the credit
          creditProvider
              .update(widget.credit)
              // Is insertion was successfull
              .then((value) => showDialog(
                    context: context,
                    builder: (_) => const SuccessDialog(),
                  ))
              // If insertion failed
              .onError((error, stackTrace) => showDialog(
                    context: context,
                    builder: (context) => ErrorDialog(
                      reason: error.toString(),
                    ),
                  ));
        }
      },
      leading: widget.additionalButtons
          ? Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              children: [
                // If it is either paid or completed
                Icon(Icons.paid,
                    color: widget.credit.payments[widget.i].isPaid ||
                            widget.credit.payments[widget.i].isCompleted
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor),

                // Switch is only activated when theres a pending payment
                // if isCompleted is true then it will be disabled
                Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: widget.credit.payments[widget.i].isPaid,
                    onChanged: widget.credit.payments[widget.i].isCompleted
                        ? null
                        : (value) async {
                            // New payment value
                            setState(() {
                              widget.credit.payments[widget.i] = widget
                                  .credit.payments[widget.i]
                                  .copyWith(isPaid: value);
                              creditProvider.update(widget.credit);
                            });
                          }),
              ],
            )
          : null,
      title: Text(widget.credit.payments[widget.i].isCompleted
          ? t.financial.paid
          : FinancialTool.formatCurrency(
              context, widget.credit.payments[widget.i].total)),
      subtitle: Text(t.models.payment.installment(number: widget.i + 1)),
      trailing: widget.credit.payments[widget.i].due != null
          ? Text(formatter.format(widget.credit.payments[widget.i].due!))
          : null,
    );
  }
}

class _PaymentDeposit extends StatelessWidget {
  const _PaymentDeposit({required this.payment});
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    // Controllers
    final formKey = GlobalKey<FormState>();
    final depositController =
        TextEditingController(text: payment.deposit?.toStringAsFixed(2));
    final expensesController =
        TextEditingController(text: payment.others?.toStringAsFixed(2));

    return AlertDialog(
      title: Text(t.screens.credit_detail.deposit_expenses),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: depositController,
                validator: _validateField,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: t.financial.deposit),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: expensesController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  } else if (double.tryParse(value) == null) {
                    return t.app.invalid;
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: t.financial.expense),
              ),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.app.cancel)),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop({
                  "deposit": Decimal.tryParse(depositController.text),
                  "expense": Decimal.tryParse(expensesController.text)
                });
              }
            },
            child: Text(t.app.save)),
      ],
    );
  }

  String? _validateField(value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (double.tryParse(value) == null) {
      return t.app.invalid;
    } else {
      return null;
    }
  }
}
