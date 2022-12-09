// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Payment _$$_PaymentFromJson(Map<String, dynamic> json) => _$_Payment(
      due: json['due'] == null ? null : DateTime.parse(json['due'] as String),
      debt: Decimal.fromJson(json['debt'] as String),
      interest: Decimal.fromJson(json['interest'] as String),
      total: Decimal.fromJson(json['total'] as String),
      others: json['others'] == null
          ? null
          : Decimal.fromJson(json['others'] as String),
      isPaid: json['isPaid'] as bool? ?? false,
      payment: json['payment'] == null
          ? null
          : Decimal.fromJson(json['payment'] as String),
    );

Map<String, dynamic> _$$_PaymentToJson(_$_Payment instance) =>
    <String, dynamic>{
      'due': instance.due?.toIso8601String(),
      'debt': instance.debt,
      'interest': instance.interest,
      'total': instance.total,
      'others': instance.others,
      'isPaid': instance.isPaid,
      'payment': instance.payment,
    };
