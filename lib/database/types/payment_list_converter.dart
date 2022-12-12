import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:credit_manager/models/payment.dart';

class ListPaymentConverter extends TypeConverter<List<Payment>, String> {
  @override
  String encode(List<Payment> value) => jsonEncode(value);

  @override
  List<Payment> decode(String databaseValue) =>
      (jsonDecode(databaseValue) as List<dynamic>)
          .map((e) => Payment.fromJson(e))
          .toList();
}
