import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/screens/card_screens/card_detail_screen.dart';
import 'package:credit_manager/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) => Consumer<CreditCardProvider>(
        builder: (_, provider, __) => FutureBuilder(
            future: provider.creditCards,
            builder: (context, snapshot) {
              // If Connection return Success
              if (snapshot.connectionState == ConnectionState.done) {
                // If it is empty
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(t.screens.cards.no_cards),
                  );
                }
                // If it is not empty
                final cards = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: cards.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) => GestureDetector(
                    child: Hero(
                        tag: "card_${cards[index].name}",
                        child: CreditCardWidget(card: cards[index])),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CardDetailScreen(creditCard: cards[index]),
                    )),
                  ),
                );
              }
              // Progress indicator
              else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
}
