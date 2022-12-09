import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/screens/cards/edit_card_screen.dart';
import 'package:credit_manager/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDetailScreen extends StatelessWidget {
  final CreditCard creditCard;
  const CardDetailScreen({super.key, required this.creditCard});

  @override
  Widget build(BuildContext context) {
    final cardsProvider = context.watch<CreditCardProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(t.screens.card_details.page_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
                tag: "card_${creditCard.name}",
                child: CreditCardWidget(card: creditCard)),
            const SizedBox(height: 12.0),
            //* Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                EditCardScreen(creditCard: creditCard),
                          )),
                      icon: const Icon(Icons.edit),
                      label: Text(t.app.edit)),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (childContext) => AlertDialog(
                                content: Text(t.screens.card_details
                                    .delete_confirmation(
                                        cardName: creditCard.name)),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(childContext).pop(),
                                      child: Text(t.app.cancel)),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).colorScheme.onError,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<CreditCardProvider>()
                                          .delete(creditCard);
                                      Navigator.of(childContext)
                                          .popUntil(ModalRoute.withName('/'));
                                    },
                                    child: Text(t.app.erase),
                                  )
                                ],
                              )),
                      icon: const Icon(Icons.delete),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onError,
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      label: Text(t.app.erase)),
                )
              ],
            ),

            //TODO: Calculate next payment
            if (creditCard.due != null) const Divider(),
            if (creditCard.due != null)
              Text(t.screens.card_details.next_payment(payment: "ATA")),

            const Divider(),
            FutureBuilder(
              future: cardsProvider.getCredits(creditCard),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    return Text(snapshot.data.toString());
                  } else {
                    return Text(t.screens.card_details.no_credits);
                  }
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
