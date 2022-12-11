import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/tools/financial_tool.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreditInstallmentsWidget extends StatelessWidget {
  const CreditInstallmentsWidget({super.key, required this.credit});
  final Credit credit;

  @override
  Widget build(BuildContext context) {
    // String formatters
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat.yMd(locale.toString());

    // ListViews
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: credit.payments.length,
      itemBuilder: (context, i) => ListTile(
        title: Text(
            FinancialTool.formatCurrency(context, credit.payments[i].total)),
        subtitle: Text(t.models.payment.installment(number: i + 1)),
        trailing: credit.payments[i].due != null
            ? Text(formatter.format(credit.payments[i].due!))
            : null,
      ),
    );
  }
}
