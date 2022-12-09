import 'package:credit_manager/models/credit.dart';
import 'package:floor/floor.dart';

@dao
abstract class CreditDao {
  @Query('SELECT * FROM Credit')
  Future<List<Credit>> allCredits();

  @Query('SELECT * FROM Credit WHERE name = :name')
  Future<Credit?> getCredit(String name);

  @update
  Future<void> updateCredit(Credit creditCard);

  @insert
  Future<void> insertCredit(Credit creditCard);

  @delete
  Future<void> deleteCredit(Credit creditCard);
}
