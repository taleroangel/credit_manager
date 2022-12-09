import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

typedef PaymentList = List<Payment>;

@freezed
class Payment with _$Payment {
  const factory Payment(
      {DateTime? due,
      required Decimal debt,
      required Decimal interest,
      required Decimal total,
      Decimal? others,
      @Default(false) bool isPaid,
      Decimal? payment}) = _Payment;

  factory Payment.fromJson(Map<String, Object?> json) =>
      _$PaymentFromJson(json);
}
