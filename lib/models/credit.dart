import 'package:credit_manager/models/credit_card.dart';
import 'package:credit_manager/models/payment.dart';
import 'package:decimal/decimal.dart';
import 'package:floor/floor.dart';

@Entity()
class Credit {
  @PrimaryKey()
  String name;

  @ForeignKey(
      childColumns: ["card"],
      parentColumns: ["name"],
      entity: CreditCard,
      onDelete: ForeignKeyAction.setNull)
  String? card;
  Decimal loan;
  Decimal interest;
  int installments;
  PaymentList payments;

  Credit(
      {this.name = "",
      this.card,
      required this.loan,
      required this.interest,
      required this.installments,
      required this.payments});
}
