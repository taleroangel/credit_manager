import 'package:credit_manager/database/credit_dao.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class CreditProvider extends ChangeNotifier {
  late final CreditDao _creditCardsDao;

  CreditProvider() {
    _creditCardsDao = GetIt.instance.get<CreditDao>();
  }

  Future<List<Credit>> get creditCards => _creditCardsDao.allCredits();

  void insert(Credit creditCard) async {
    await _creditCardsDao.insertCredit(creditCard);
    notifyListeners();
  }

  void delete(Credit creditCard) async {
    await _creditCardsDao.deleteCredit(creditCard);
    notifyListeners();
  }

  void update(Credit creditCard) async {
    await _creditCardsDao.updateCredit(creditCard);
    notifyListeners();
  }

  Future<Credit?> getByName(String name) {
    return _creditCardsDao.getCredit(name);
  }
}
