import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/models/payment.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';

class FinancialTool {
  // Rational numbers like (10/3) infinite decimal precision scale
  static const rationalInfinitePrecisionScale = 5;

  static final CurrencyFormatterSettings currencyFormatterEN =
      CurrencyFormatterSettings(
          symbol: '\$',
          symbolSide: SymbolSide.left,
          thousandSeparator: ',',
          decimalSeparator: '.',
          symbolSeparator: ' ');

  static final CurrencyFormatterSettings currencyFormatterES =
      CurrencyFormatterSettings(
          symbol: '\$',
          symbolSide: SymbolSide.left,
          thousandSeparator: ',',
          decimalSeparator: '.',
          symbolSeparator: ' ');

  /// Calculate a credit and return the corresponding [List<Payment>] (Installments)
  static List<Payment> calculateCredit(
      {required Decimal debt,
      required int installments,
      required Decimal interest,
      Decimal? others,
      DateTime? initial}) {
    // One only, no interest
    if (installments == 1) {
      return [Payment(debt: Decimal.zero, interest: Decimal.zero, total: debt)];
    }

    // Required variables
    // Transform interest % into double
    interest = (interest / Decimal.fromInt(100))
        .toDecimal(scaleOnInfinitePrecision: rationalInfinitePrecisionScale);

    // Calculate base installment (Fixed)
    final baseInstallment = (debt / Decimal.fromInt(installments))
        .toDecimal(scaleOnInfinitePrecision: rationalInfinitePrecisionScale);

    // Array with debts
    final debts = List<Decimal>.filled(installments, Decimal.zero);

    // Array of payments
    final payments = List<Payment>.empty(growable: true);

    // For every installment
    for (int i = 0; i < installments; i++) {
      // Calculate base debt (Previous debt - base installment)
      debts[i] = (i == 0) ? debt : (debts[i - 1] - baseInstallment);
      // Reduce debt by additional payment
      final installment = (debts[i] * interest);
      var total = (baseInstallment + installment + (others ?? Decimal.zero));

      if (total > (debts[i] + installment + (others ?? Decimal.zero))) {
        total = (debts[i] + installment + (others ?? Decimal.zero));
      }

      // Append payment
      payments.add(Payment(
          debt: debts[i], interest: installment, others: others, total: total));
    }

    return generatePaymentsDues(payments, initial);
  }

  static List<Payment> recalculateCredit(Credit credit) {
    // Copy credits
    final originalPayments = [...credit.payments];

    // Calculate base installment
    final baseInstallment = (credit.loan / Decimal.fromInt(credit.installments))
        .toDecimal(scaleOnInfinitePrecision: rationalInfinitePrecisionScale);

    // Calculate interest in M.A%
    final interest = (credit.interest / Decimal.fromInt(100))
        .toDecimal(scaleOnInfinitePrecision: rationalInfinitePrecisionScale);

    // Array with debts
    final debts = List<Decimal>.filled(credit.installments, Decimal.zero);

    // Array of payments
    final payments = List<Payment>.empty(growable: true);

    // For each payment
    for (int i = 0; i < credit.installments; i++) {
      // Calculate base debt (Previous debt - base installment)
      debts[i] = (i == 0) ? credit.loan : (debts[i - 1] - baseInstallment);
      // Reduce debt by additional payment
      debts[i] -= originalPayments[i].deposit ?? Decimal.zero;

      // Calculate installment
      final installment = (debts[i] * interest);
      final others = credit.payments[i].others;
      var total = (baseInstallment +
          installment +
          (originalPayments[i].others ?? Decimal.zero));
      if (total > (debts[i] + installment + (others ?? Decimal.zero))) {
        total = (debts[i] + installment + (others ?? Decimal.zero));
      }
      // Append payment
      payments.add(originalPayments[i].copyWith(
          debt: debts[i],
          interest: installment,
          total: (debts[i] < Decimal.zero ? Decimal.zero : total),
          isCompleted: (debts[i] < Decimal.zero)));
    }

    // Return modified credits
    return payments;
  }

  /// Return currency formated with 2 decimal places and a locale currency symbol
  static String formatCurrency(BuildContext context, dynamic value) {
    return CurrencyFormatter.format(
        value,
        Localizations.localeOf(context).toString() == "ES"
            ? currencyFormatterES
            : currencyFormatterEN);
  }

  /// Update all installments due dates based on creditCard due
  static List<Payment> updatePayments(
      List<Payment> payments, CreditCard creditCard) {
    final dayDue = creditCard.due ?? 1;
    // Calculate datetime
    int monthOffset = 0;
    return payments
        .map((e) => e.copyWith(
            due: DateTime(e.due!.year, e.due!.month + (monthOffset++), dayDue)))
        .toList();
  }

  /// Generate due dates for payments
  static List<Payment> generatePaymentsDues(List<Payment> payments,
      [DateTime? initial]) {
    final now = initial ?? DateTime.now();
    int monthOffset = 0;
    return payments
        .map((e) => e.copyWith(
            due: DateTime(now.year, now.month + (monthOffset++), now.day)))
        .toList();
  }

  // Calculate total debt (Sum of all credits)
  static Decimal totalDebt(List<Credit?> credits) {
    if (credits.isEmpty) return Decimal.zero;
    Decimal totalDebt = Decimal.zero;
    for (var element in credits) {
      totalDebt += element!.loan;
    }
    return totalDebt;
  }

  // Calculate month total from all Credits
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
