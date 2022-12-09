import 'dart:async';
import 'package:credit_manager/database/credit_dao.dart';
import 'package:credit_manager/database/types/color_converter.dart';
import 'package:credit_manager/database/types/decimal_converter.dart';
import 'package:credit_manager/database/types/fee_type_converter.dart';
import 'package:credit_manager/database/types/icon_data_converter.dart';
import 'package:credit_manager/database/types/payment_list_converter.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:credit_manager/database/types/date_time_converter.dart';
import 'package:floor/floor.dart';

import 'package:credit_manager/database/credit_card_dao.dart';
import 'package:credit_manager/models/credit_card.dart';

part 'application_database.g.dart';

@TypeConverters([
  DateTimeConverter,
  IconDataConverter,
  ColorConverter,
  FeeTypeConverter,
  PaymentListConverter,
  DecimalConverter
])
@Database(version: 1, entities: [CreditCard, Credit])
abstract class ApplicationDatabase extends FloorDatabase {
  CreditCardDao get creditCardDao;
  CreditDao get creditDao;
}
