import 'package:credit_manager/database/credit_dao.dart';
import 'package:credit_manager/models/credit.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class CreditProvider extends ChangeNotifier {
  late final CreditDao _creditCardsDao;

  CreditProvider() {
    _creditCardsDao = GetIt.instance.get<CreditDao>();
  }

  Future<List<Credit>> get credits => _creditCardsDao.allCredits();

  Future<void> insert(Credit credit) async {
    await _creditCardsDao.insertCredit(credit);
    notifyListeners();
  }

  Future<void> delete(Credit credit) async {
    await _creditCardsDao.deleteCredit(credit);
    notifyListeners();
  }

  Future<void> update(Credit credit) async {
    await _creditCardsDao.updateCredit(credit);
    notifyListeners();
  }

  Future<Credit?> getByName(String name) {
    return _creditCardsDao.getCredit(name);
  }
}
