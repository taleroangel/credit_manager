import 'package:flutter/material.dart';

class IconPicker extends StatelessWidget {
  const IconPicker({super.key});

  static const List<IconData> icons = [
    Icons.cancel,
    Icons.credit_card,
    Icons.school,
    Icons.redeem,
    Icons.shopping_bag,
    Icons.restaurant,
    Icons.local_gas_station,
    Icons.health_and_safety
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15.0,
      runSpacing: 15.0,
      children: [
        for (var icon in icons)
          GestureDetector(
            onTap: () =>
                Navigator.pop(context, icon != Icons.cancel ? icon : null),
            child: Icon(icon),
          )
      ],
    );
  }
}
