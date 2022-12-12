import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/providers/credit_provider.dart';
import 'package:credit_manager/screens/card_screens/edit_card_screen.dart';
import 'package:credit_manager/tools/financial_tool.dart';
import 'package:credit_manager/widgets/dialogs/erase_confirmation_dialog.dart';
import 'package:credit_manager/widgets/dialogs/error_dialog.dart';
import 'package:credit_manager/widgets/dialogs/success_dialog.dart';
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
    context.watch<CreditProvider>(); // Watch for credit changes
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
                          builder: (_) => EraseConfirmationDialog(
                              name: creditCard.name,
                              onDelete: () => deleteCardAndCredits(context))),
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
            FutureBuilder(
              future: cardsProvider.getCredits(creditCard),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    //* Calculate next payment
                    double monthDebt = 0.0;

                    // Calculate next credits
                    if (snapshot.data!.isNotEmpty) {
                      monthDebt =
                          FinancialTool.monthInstallments(snapshot.data!)
                              .toDouble();
                    }

                    // If no other data provided aside from FeeType
                    switch (creditCard.feeType) {
                      // Fixed rate
                      case FeeType.fixed:
                        monthDebt += creditCard.fee;
                        break;

                      // Only while using it
                      case FeeType.whileUsing:
                        if (snapshot.data!.isNotEmpty) {
                          monthDebt += creditCard.fee;
                        } else {
                          monthDebt += 0.0;
                        }
                        break;

                      // No fee
                      case FeeType.none:
                      default:
                        monthDebt += 0.0;
                        break;
                    }

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //* Show next payment
                          if (creditCard.due != null)
                            Text(t.screens.card_details.next_payment(
                                payment: FinancialTool.formatCurrency(
                                    context, monthDebt))),

                          //* Show total Debt
                          Text(t.screens.card_details.total_debt(
                              debt: FinancialTool.formatCurrency(
                                  context,
                                  FinancialTool.totalDebt(
                                      snapshot.data ?? [])))),

                          //* Show Credits
                          const Divider(),
                          const SizedBox(height: 16.0),
                          if (snapshot.data!.isNotEmpty)
                            Text(t.screens.card_details.your_credits,
                                style: Theme.of(context).textTheme.titleLarge),
                          if (snapshot.data!.isEmpty)
                            Text(
                              t.screens.card_details.no_credits,
                              textAlign: TextAlign.center,
                            ),

                          if (snapshot.data!.isNotEmpty)
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (_, i) =>
                                  CreditWidget(credit: snapshot.data![i]!),
                            ),
                        ]);
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

  void deleteCardAndCredits(BuildContext context) async {
    // Get Providers
    final creditProvider = context.read<CreditProvider>();
    final creditCardProvider = context.read<CreditCardProvider>();

    try {
      // Delete all credtis
      final credits = await creditCardProvider.getCredits(creditCard);

      for (var credit in credits) {
        await creditProvider.delete(credit!);
      }

      // Delete credit card
      await creditCardProvider.delete(creditCard);
      // Is insertion was successfull
      showDialog(
        context: context,
        builder: (_) => const SuccessDialog(),
      ).then(
          (value) => Navigator.of(context).popUntil(ModalRoute.withName('/')));
    } catch (error) {
      // If insertion failed
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          reason: error.toString(),
        ),
      );
    }
  }
}
