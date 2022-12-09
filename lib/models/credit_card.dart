import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

enum FeeType { none, fixed, whileUsing }

@Entity()
class CreditCard {
  @PrimaryKey()
  String name;
  Color color;
  IconData? icon;
  double fee;
  FeeType feeType;
  int? due;

  CreditCard({
    this.name = "",
    this.color = Colors.green,
    this.icon,
    this.fee = 0.0,
    this.feeType = FeeType.none,
    this.due,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "color": color.value,
        "icon": icon?.codePoint,
        "fee": fee,
        "feeType": feeType.index,
        "due": due,
      };

  @override
  String toString() => toMap().toString();
}
