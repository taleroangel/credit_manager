import 'package:credit_manager/database/credit_card_dao.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:credit_manager/models/credit_card.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class CreditCardProvider extends ChangeNotifier {
  late final CreditCardDao _creditCardsDao;

  CreditCardProvider() {
    _creditCardsDao = GetIt.instance.get<CreditCardDao>();
  }

  Future<List<CreditCard>> get creditCards => _creditCardsDao.allCreditCards();

  Future<void> insert(CreditCard creditCard) async {
    final result = await _creditCardsDao.insertCreditCard(creditCard);
    notifyListeners();
    return result;
  }

  Future<void> delete(CreditCard creditCard) async {
    final result = await _creditCardsDao.deleteCreditCard(creditCard);
    notifyListeners();
    return result;
  }

  Future<void> update(CreditCard creditCard) async {
    final result = await _creditCardsDao.updateCreditCard(creditCard);
    notifyListeners();
    return result;
  }

  Future<CreditCard?> getByName(String name) {
    return _creditCardsDao.getCreditCard(name);
  }

  Future<List<Credit?>> getCredits(CreditCard creditCard) {
    return _creditCardsDao.cardCredits(creditCard.name);
  }
}
