import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/widgets/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/widgets/credit_card_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

/// Edit a [CreditCard], Requires a [Provider] with a [CreditCard], usually in the form of a [ProxyProvider0]
class CardField extends StatefulWidget {
  const CardField(
      {super.key, required this.formKey, this.enablePrimaryKey = true});
  final GlobalKey<FormState> formKey;
  final bool enablePrimaryKey;

  @override
  State<CardField> createState() => _CardFieldState();
}

class _CardFieldState extends State<CardField> {
  @override
  Widget build(BuildContext context) {
    final card = context.watch<CreditCard>();
    Color pickerColor = card.color;
    return ListView(
      padding: const EdgeInsets.all(28.0),
      children: [
        CreditCardWidget(card: card),
        const SizedBox(height: 12.0),
        Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: widget.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.enablePrimaryKey)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      t.screens.card_edit.info_card_name,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                //* Card name input
                TextFormField(
                  enabled: widget.enablePrimaryKey,
                  initialValue: card.name,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: t.models.credit_card.name),
                  validator: (value) => nameValidator(t, value),
                  onChanged: (value) => setState(() {
                    card.name = value;
                  }),
                ),
                const SizedBox(height: 12.0),
                //* Color and Icon Selection
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 10.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      height: 21.0,
                      width: 21.0,
                      decoration: BoxDecoration(
                          color: card.color,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(80.0))),
                    ),
                    ElevatedButton.icon(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    t.screens.card_edit.color_picker_title),
                                content: SingleChildScrollView(
                                    child: ColorPicker(
                                  pickerColor: card.color,
                                  onColorChanged: (value) =>
                                      (pickerColor = value),
                                )),
                                actions: [
                                  ElevatedButton(
                                    child: Text(t.app.cancel),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Text(t.app.accept),
                                    onPressed: () {
                                      setState(() {
                                        card.color = pickerColor;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                        icon: const Icon(Icons.color_lens),
                        label: Text(t.screens.card_edit.color_pick)),
                    Icon(card.icon ?? Icons.cancel),
                    ElevatedButton.icon(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      t.screens.card_edit.icon_picker_title),
                                  content: const SingleChildScrollView(
                                      child: IconPicker()),
                                  actions: [
                                    ElevatedButton(
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style,
                                      child: Text(t.app.cancel),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )).then((value) => setState(() {
                              card.icon = value;
                            })),
                        icon: const Icon(Icons.category),
                        label: Text(t.screens.card_edit.icon_pick)),
                  ],
                ),
                const SizedBox(height: 12.0),
                //* Card Fee input
                DropdownButtonFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    value: card.feeType,
                    isExpanded: true,
                    items: [
                      for (var item in FeeType.values)
                        DropdownMenuItem(
                          value: item,
                          child:
                              Text(t.models.credit_card.fee_type[item.index]),
                        )
                    ],
                    onChanged: (value) => setState(() {
                          card.feeType = value!;
                        })),
                const SizedBox(height: 12.0),
                TextFormField(
                  enabled: card.feeType != FeeType.none,
                  initialValue: card.fee.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9]|\."))
                  ],
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: t.financial.fee),
                  onChanged: (value) => setState(() {
                    card.fee = value.isEmpty ? 0 : double.parse(value);
                  }),
                ),
                //* Card due day
                const SizedBox(height: 12.0),
                TextFormField(
                    initialValue: card.due?.toString() ?? "",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => validateDueDay(t, value),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: t.financial.due),
                    onChanged: (value) => setState(() {
                          card.due = value.isEmpty ? null : int.parse(value);
                        })),
              ],
            ))
      ],
    );
  }

  String? nameValidator(t, String? value) {
    if (value == null || value.isEmpty) {
      return t.screens.card_edit.error_card_name;
    }
    return null;
  }

  String? validateDueDay(t, String? value) {
    int day;
    try {
      day = int.parse(value!);
    } catch (_) {
      return null;
    }
    if (day > 31 || day < 0) {
      return t.screens.card_edit.error_due_day;
    } else {
      return null;
    }
  }
}
