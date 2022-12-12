import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    DateTime? due, // Payment due DateTime
    required Decimal debt, // Total debt in installment
    required Decimal interest, // Interest in M.A %
    required Decimal total, // Total for this installment
    Decimal? others, // Any other expenses that add to the total
    Decimal? deposit, // Additional payment (Reduces debt)
    @Default(false) bool isPaid, // This installment was paid
    @Default(false) bool isCompleted, // No payment required
  }) = _Payment;

  factory Payment.fromJson(Map<String, Object?> json) =>
      _$PaymentFromJson(json);
}
