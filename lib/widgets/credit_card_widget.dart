import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCard card;
  const CreditCardWidget({super.key, required this.card});

  static const cardDimentionsRatio = 0.628;
  static const cardBorderRadius = 15.0;
  static const cardInnerPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    final fontColor =
        ThemeData.estimateBrightnessForColor(card.color) == Brightness.light
            ? Colors.black
            : Colors.white;
    return Material(
      child: LayoutBuilder(
        builder: (_, constraints) => Container(
          width: constraints.maxWidth,
          height: constraints.maxWidth * cardDimentionsRatio,
          decoration: BoxDecoration(
              color: card.color,
              borderRadius:
                  const BorderRadius.all(Radius.circular(cardBorderRadius))),
          child: Stack(children: [
            Positioned(
              top: cardInnerPadding,
              left: cardInnerPadding,
              child: Text(card.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: cardInnerPadding,
                      color: fontColor)),
            ),
            if (card.icon != null)
              Positioned(
                top: cardInnerPadding,
                right: cardInnerPadding,
                child: Icon(
                  card.icon,
                  color: fontColor,
                ),
              ),
            if (card.feeType != FeeType.none)
              Positioned(
                left: cardInnerPadding,
                bottom: cardInnerPadding,
                child: Text.rich(
                    TextSpan(
                        text:
                            "${t.models.credit_card.fee_type[card.feeType.index]}\n",
                        children: [
                          TextSpan(text: "${t.financial.fee}: ${card.fee} \$")
                        ]),
                    style: TextStyle(color: fontColor)),
              ),
            if (card.due != null)
              Positioned(
                bottom: cardInnerPadding,
                right: cardInnerPadding,
                child: Text("${t.financial.due}: ${card.due!}",
                    style: TextStyle(color: fontColor)),
              )
          ]),
        ),
      ),
    );
  }
}
