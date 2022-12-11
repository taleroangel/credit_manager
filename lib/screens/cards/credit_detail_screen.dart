import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/widgets/credit_installments_widget.dart';
import 'package:credit_manager/widgets/credit_widget.dart';
import 'package:flutter/material.dart';

class CreditDetailScreen extends StatelessWidget {
  const CreditDetailScreen({required this.credit, super.key});
  final Credit credit;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (_, __) => [
                  SliverAppBar.medium(
                      centerTitle: true,
                      title: Text(t.screens.credit_detail.page_title))
                ],
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: ListView(
                children: [
                  Card(
                    child: AbsorbPointer(child: CreditWidget(credit: credit)),
                  ),
                  CreditInstallmentsWidget(credit: credit)
                ],
              ),
            )),
      );
}
