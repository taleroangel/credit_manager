import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:credit_manager/models/payment.dart';

class PaymentListConverter extends TypeConverter<PaymentList, String> {
  @override
  String encode(PaymentList value) => jsonEncode(value);

  @override
  PaymentList decode(String databaseValue) => jsonDecode(databaseValue);
}
