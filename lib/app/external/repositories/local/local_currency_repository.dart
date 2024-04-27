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
}
