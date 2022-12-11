import 'package:credit_manager/models/credit.dart';
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
      Decimal? others,
      DateTime? initial}) {
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

    return generatePaymentsDues(payments, initial);
  }

  static String formatCurrency(BuildContext context, dynamic value) {
    final locale = Localizations.localeOf(context);
    final currencySymbol =
        NumberFormat.simpleCurrency(locale: locale.toString()).currencySymbol;
    return "$currencySymbol ${value.toStringAsFixed(2)}";
  }

  static PaymentList updatePayments(
      PaymentList payments, CreditCard creditCard) {
    final dayDue = creditCard.due ?? 1;
    // Calculate datetime
    int monthOffset = 0;
    return payments
        .map((e) => e.copyWith(
            due: DateTime(e.due!.year, e.due!.month + (monthOffset++), dayDue)))
        .toList();
  }

  static PaymentList generatePaymentsDues(PaymentList payments,
      [DateTime? initial]) {
    final now = initial ?? DateTime.now();
    int monthOffset = 0;
    return payments
        .map((e) => e.copyWith(
            due: DateTime(now.year, now.month + (monthOffset++), now.day)))
        .toList();
  }

  static Decimal totalDebt(List<Credit?> credits) {
    if (credits.isEmpty) return Decimal.zero;
    Decimal totalDebt = Decimal.zero;
    for (var element in credits) {
      totalDebt += element!.loan;
    }
    return totalDebt;
  }

  static Decimal monthInstallments(List<Credit?> credits) {
    final now = DateTime.now();
    Decimal total = Decimal.zero;
    for (var credit in credits) {
      try {
        total += credit!.payments
            .where((element) =>
                (element.due!.month == now.month) &&
                (element.due!.year == now.year))
            .map((e) => e.total)
            .reduce((value, element) => (value + element));
      } catch (_) {}
    }
    return total;
  }
}
