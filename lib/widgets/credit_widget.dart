import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:flutter/material.dart';

class CreditWidget extends StatelessWidget {
  const CreditWidget({super.key, required this.credit});
  final Credit credit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(credit.name),
      subtitle: Text(credit.loan.toString()),
      trailing: Text.rich(TextSpan(children: [
        TextSpan(text: "${t.financial.interest}: ${credit.interest}%\n"),
        TextSpan(text: "${t.financial.term}: ${credit.installments}")
      ])),
    );
  }
}
