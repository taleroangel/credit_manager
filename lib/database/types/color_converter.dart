import 'package:floor/floor.dart';
import 'package:flutter/painting.dart';

class ColorConverter extends TypeConverter<Color, int> {
  @override
  int encode(Color value) {
    return value.value;
  }

  @override
  Color decode(int databaseValue) {
    return Color(databaseValue);
  }
}
