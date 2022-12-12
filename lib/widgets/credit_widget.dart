import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/screens/credit_screens/credit_detail_screen.dart';
import 'package:credit_manager/tools/financial_tool.dart';
import 'package:flutter/material.dart';

class CreditWidget extends StatelessWidget {
  const CreditWidget({super.key, required this.credit});
  final Credit credit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(credit.name),
      subtitle: Text(FinancialTool.formatCurrency(context, credit.loan)),
      trailing: Text.rich(TextSpan(children: [
        TextSpan(text: "${t.financial.interest_ma}: ${credit.interest}%\n"),
        TextSpan(text: "${t.financial.term}: ${credit.installments}")
      ])),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreditDetailScreen(credit: credit),
      )),
    );
  }
}
