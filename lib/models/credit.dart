import 'package:credit_manager/models/credit_card.dart';
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
  double loan;
  double interest;
  int term;

  Credit(
      {this.name = "",
      this.card,
      required this.loan,
      required this.interest,
      required this.term});
}
