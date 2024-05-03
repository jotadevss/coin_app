import 'package:coin_app/app/interactor/models/currency.dart';

abstract class ICurrencyRepository {
  Future<List<Currency>> getAllCurrencies();
  Future<Currency> getByCodeIn(String codeIn);
  Future<Currency> getByCodeOut(String codeOut);
}
