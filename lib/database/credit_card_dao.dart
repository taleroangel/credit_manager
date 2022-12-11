import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:floor/floor.dart';

@dao
abstract class CreditCardDao {
  @Query('SELECT * FROM CreditCard')
  Future<List<CreditCard>> allCreditCards();

  @Query('SELECT * FROM CreditCard WHERE name = :name')
  Future<CreditCard?> getCreditCard(String name);

  @update
  Future<void> updateCreditCard(CreditCard creditCard);

  @insert
  Future<void> insertCreditCard(CreditCard creditCard);

  @delete
  Future<void> deleteCreditCard(CreditCard creditCard);

  @Query('SELECT * FROM Credit WHERE card = :name')
  Future<List<Credit?>> cardCredits(String name);
}
