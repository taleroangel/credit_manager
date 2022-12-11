import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/providers/credit_provider.dart';
import 'package:credit_manager/tools/financial_tool.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreditInstallmentsWidget extends StatelessWidget {
  const CreditInstallmentsWidget(
      {super.key, required this.credit, this.additionalButtons = false});
  final Credit credit;
  final bool additionalButtons;

  @override
  Widget build(BuildContext context) {
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
          additionalButtons: additionalButtons,
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
  State<_ListItem> createState() => __ListItemState();
}

class __ListItemState extends State<_ListItem> {
  @override
  Widget build(BuildContext context) {
    // String formatters
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat.yMd(locale.toString());

    return ListTile(
      leading: widget.additionalButtons
          ? Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              children: [
                Icon(Icons.paid,
                    color: widget.credit.payments[widget.i].isPaid
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor),
                Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: widget.credit.payments[widget.i].isPaid,
                    onChanged: (value) async {
                      // New payment value
                      setState(() {
                        widget.credit.payments[widget.i] = widget
                            .credit.payments[widget.i]
                            .copyWith(isPaid: value);
                        context.read<CreditProvider>().update(widget.credit);
                      });
                    }),
              ],
            )
          : null,
      title: Text(FinancialTool.formatCurrency(
          context, widget.credit.payments[widget.i].total)),
      subtitle: Text(t.models.payment.installment(number: widget.i + 1)),
      trailing: widget.credit.payments[widget.i].due != null
          ? Text(formatter.format(widget.credit.payments[widget.i].due!))
          : null,
    );
  }
}
