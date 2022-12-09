import 'package:credit_manager/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          Form(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]|\."))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: t.financial.loan)),
                  const SizedBox(height: 16.0),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]|\."))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: t.financial.interest)),
                  const SizedBox(height: 16.0),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                      ],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: t.financial.term))
                ]),
          )
        ],
      );
}
