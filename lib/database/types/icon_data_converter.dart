import 'package:floor/floor.dart';
import 'package:flutter/widgets.dart';

class IconDataConverter extends TypeConverter<IconData?, int?> {
  @override
  IconData? decode(int? databaseValue) {
    if (databaseValue == null) return null;
    return IconData(databaseValue, fontFamily: 'MaterialIcons');
  }

  @override
  int? encode(IconData? value) {
    if (value == null) return null;
    return value.codePoint;
  }
}
