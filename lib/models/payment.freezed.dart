// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  DateTime? get due => throw _privateConstructorUsedError;
  Decimal get debt => throw _privateConstructorUsedError;
  Decimal get interest => throw _privateConstructorUsedError;
  Decimal get total => throw _privateConstructorUsedError;
  Decimal? get others => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  Decimal? get payment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {DateTime? due,
      Decimal debt,
      Decimal interest,
      Decimal total,
      Decimal? others,
      bool isPaid,
      Decimal? payment});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? due = freezed,
    Object? debt = null,
    Object? interest = null,
    Object? total = null,
    Object? others = freezed,
    Object? isPaid = null,
    Object? payment = freezed,
  }) {
    return _then(_value.copyWith(
      due: freezed == due
          ? _value.due
          : due // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      debt: null == debt
          ? _value.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as Decimal,
      interest: null == interest
          ? _value.interest
          : interest // ignore: cast_nullable_to_non_nullable
              as Decimal,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as Decimal,
      others: freezed == others
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as Decimal?,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as Decimal?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$_PaymentCopyWith(
          _$_Payment value, $Res Function(_$_Payment) then) =
      __$$_PaymentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? due,
      Decimal debt,
      Decimal interest,
      Decimal total,
      Decimal? others,
      bool isPaid,
      Decimal? payment});
}

/// @nodoc
class __$$_PaymentCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$_Payment>
    implements _$$_PaymentCopyWith<$Res> {
  __$$_PaymentCopyWithImpl(_$_Payment _value, $Res Function(_$_Payment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? due = freezed,
    Object? debt = null,
    Object? interest = null,
    Object? total = null,
    Object? others = freezed,
    Object? isPaid = null,
    Object? payment = freezed,
  }) {
    return _then(_$_Payment(
      due: freezed == due
          ? _value.due
          : due // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      debt: null == debt
          ? _value.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as Decimal,
      interest: null == interest
          ? _value.interest
          : interest // ignore: cast_nullable_to_non_nullable
              as Decimal,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as Decimal,
      others: freezed == others
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as Decimal?,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as Decimal?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payment implements _Payment {
  const _$_Payment(
      {this.due,
      required this.debt,
      required this.interest,
      required this.total,
      this.others,
      this.isPaid = false,
      this.payment});

  factory _$_Payment.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentFromJson(json);

  @override
  final DateTime? due;
  @override
  final Decimal debt;
  @override
  final Decimal interest;
  @override
  final Decimal total;
  @override
  final Decimal? others;
  @override
  @JsonKey()
  final bool isPaid;
  @override
  final Decimal? payment;

  @override
  String toString() {
    return 'Payment(due: $due, debt: $debt, interest: $interest, total: $total, others: $others, isPaid: $isPaid, payment: $payment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payment &&
            (identical(other.due, due) || other.due == due) &&
            (identical(other.debt, debt) || other.debt == debt) &&
            (identical(other.interest, interest) ||
                other.interest == interest) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.others, others) || other.others == others) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.payment, payment) || other.payment == payment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, due, debt, interest, total, others, isPaid, payment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentCopyWith<_$_Payment> get copyWith =>
      __$$_PaymentCopyWithImpl<_$_Payment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {final DateTime? due,
      required final Decimal debt,
      required final Decimal interest,
      required final Decimal total,
      final Decimal? others,
      final bool isPaid,
      final Decimal? payment}) = _$_Payment;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$_Payment.fromJson;

  @override
  DateTime? get due;
  @override
  Decimal get debt;
  @override
  Decimal get interest;
  @override
  Decimal get total;
  @override
  Decimal? get others;
  @override
  bool get isPaid;
  @override
  Decimal? get payment;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentCopyWith<_$_Payment> get copyWith =>
      throw _privateConstructorUsedError;
}
