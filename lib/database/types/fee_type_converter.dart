import 'package:credit_manager/models/credit_card.dart';
import 'package:floor/floor.dart';

class FeeTypeConverter extends TypeConverter<FeeType, int> {
  @override
  int encode(FeeType value) => value.index;

  @override
  FeeType decode(int databaseValue) => FeeType.values[databaseValue];
}
