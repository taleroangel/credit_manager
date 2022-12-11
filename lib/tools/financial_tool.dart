import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/models/payment.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FinancialTool {
  static PaymentList calculateCredit(
      {required Decimal debt,
      required int installments,
      required Decimal interest,
      Decimal? others}) {
    // Required variables
    interest = (interest / Decimal.fromInt(100))
        .toDecimal(scaleOnInfinitePrecision: 5);
    final baseInstallment = (debt / Decimal.fromInt(installments))
        .toDecimal(scaleOnInfinitePrecision: 5);
    final debts = List<Decimal>.filled(installments, Decimal.zero);
    final payments = PaymentList.empty(growable: true);

    // Calculated payments
    for (int i = 0; i < installments; i++) {
      // Calculate debt and interest
      debts[i] = (i == 0) ? debt : (debts[i - 1] - baseInstallment);
      final installment = (debts[i] * interest);
      // Append payment
      payments.add(Payment(
          debt: debts[i],
          interest: installment,
          others: others,
          total: (baseInstallment + installment + (others ?? Decimal.zero))));
    }

    return payments;
  }

  static String formatCurrency(BuildContext context, dynamic value) {
    final locale = Localizations.localeOf(context);
    final currencySymbol =
        NumberFormat.simpleCurrency(locale: locale.toString()).currencySymbol;
    return "$currencySymbol ${value.toStringAsFixed(2)}";
  }

  static PaymentList updatePayments(
      PaymentList payments, CreditCard creditCard) {
    if (creditCard.due == null) return payments;

    // Calculate datetime
    final now = DateTime.now();
    int monthOffset = 0;
    payments.map((e) => e.copyWith(
        due: DateTime(now.year, now.month + (monthOffset++), creditCard.due!)));

    return payments;
  }
}
