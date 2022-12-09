import 'package:decimal/decimal.dart';
import 'package:floor/floor.dart';

class DecimalConverter extends TypeConverter<Decimal, String> {
  @override
  String encode(Decimal value) => value.toString();

  @override
  Decimal decode(String databaseValue) => Decimal.parse(databaseValue);
}
