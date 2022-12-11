import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/screens/cards/edit_card_screen.dart';
import 'package:credit_manager/screens/dialogs/error_dialog.dart';
import 'package:credit_manager/screens/dialogs/success_dialog.dart';
import 'package:credit_manager/widgets/credit_card_widget.dart';
import 'package:credit_manager/widgets/credit_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDetailScreen extends StatelessWidget {
  final CreditCard creditCard;
  const CardDetailScreen({super.key, required this.creditCard});

  @override
  Widget build(BuildContext context) {
    // CardsProvider for getting Card information
    final cardsProvider = context.watch<CreditCardProvider>();

    // Build widget
    return Scaffold(
      appBar: AppBar(title: Text(t.screens.card_details.page_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
                  //* Delete Button
                  child: ElevatedButton.icon(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (_) =>
                              _EraseConfirmationDialog(creditCard: creditCard)),
                      icon: const Icon(Icons.delete),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onError,
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      label: Text(t.app.erase)),
                )
              ],
            ),
            const Divider(),
            Column(
              children: [
                //TODO: Calculate next payment
                //* Show next payment
                if (creditCard.due != null) const Divider(),
                if (creditCard.due != null)
                  Text(t.screens.card_details.next_payment(payment: "ATA")),

                //* Show Credits
                const SizedBox(height: 16.0),
                Text(t.screens.card_details.your_credits,
                    style: Theme.of(context).textTheme.titleLarge),
                FutureBuilder(
                  future: cardsProvider.getCredits(creditCard),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, i) =>
                              CreditWidget(credit: snapshot.data![i]!),
                        );
                      } else {
                        return Text(t.screens.card_details.no_credits);
                      }
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _EraseConfirmationDialog extends StatelessWidget {
  const _EraseConfirmationDialog({required this.creditCard});
  final CreditCard creditCard;

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Text(t.screens.card_details
            .delete_confirmation(cardName: creditCard.name)),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.app.cancel)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onError,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              context
                  .read<CreditCardProvider>()
                  .delete(creditCard)
                  // Is insertion was successfull
                  .then((value) => showDialog(
                        context: context,
                        builder: (_) => const SuccessDialog(),
                      ).then((value) => Navigator.of(context)
                          .popUntil(ModalRoute.withName('/'))))
                  // If insertion failed
                  .onError((error, stackTrace) => showDialog(
                        context: context,
                        builder: (context) => ErrorDialog(
                          reason: error.toString(),
                        ),
                      ));
            },
            child: Text(t.app.erase),
          )
        ],
      );
}
