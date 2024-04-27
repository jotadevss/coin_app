import 'package:coin_app/app/interactor/models/currency.dart';

abstract class ICurrencyRepository {
  Future<List<Currency>> getAllCurrencies();
}
