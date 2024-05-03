import 'package:coin_app/app/external/adapters/currencies_adapter.dart';
import 'package:coin_app/app/interactor/contracts/repositories/currencies_repository.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/shared/constants/constants.dart';

class LocalCurrencyRepository implements ICurrencyRepository {
  @override
  Future<List<Currency>> getAllCurrencies() async {
    try {
      const currenciesMap = AppConstants.currencies;
      final currencies = CurrencyAdapter.fromMap(currenciesMap);
      return currencies;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Currency> getByCodeIn(String codeIn) async {
    try {
      const currenciesMap = AppConstants.currencies;
      final allCurrencies = CurrencyAdapter.fromMap(currenciesMap);
      final currenciesByCodeIn = allCurrencies.where((e) => e.code == codeIn).toList();
      return currenciesByCodeIn[0];
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Currency> getByCodeOut(String codeOut) async {
    try {
      const currenciesMap = AppConstants.currencies;
      final allCurrencies = CurrencyAdapter.fromMap(currenciesMap);
      final currenciesByCodeOut = allCurrencies.where((e) => e.code == codeOut).toList();
      return currenciesByCodeOut[0];
    } catch (e) {
      throw Exception(e);
    }
  }
}
