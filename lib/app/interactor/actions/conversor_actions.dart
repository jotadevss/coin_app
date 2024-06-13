// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coin_app/app/interactor/models/currency.dart';

sealed class ConversorAction {}

class ChangeCurrencyInAction extends ConversorAction {
  final Currency currencyIn;

  ChangeCurrencyInAction({
    required this.currencyIn,
  });
}

class ChangeCurrencyOutAction extends ConversorAction {
  final Currency currencyOut;

  ChangeCurrencyOutAction({
    required this.currencyOut,
  });
}

class FetchAllCurrenciesAction1 extends ConversorAction {}

class SetDefaultValuesAction extends ConversorAction {}

class ChangeInputValueRateAction extends ConversorAction {
  final String valueFormatted;

  ChangeInputValueRateAction({
    required this.valueFormatted,
  });
}

class SearchCurrencyByInputAction extends ConversorAction {
  final List<Currency> currencies;
  final String input;

  SearchCurrencyByInputAction({
    required this.currencies,
    required this.input,
  });
}

class FlipCurrenciesAction extends ConversorAction {}
