// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coin_app/app/interactor/models/currency.dart';

sealed class CurrencyState {}

class InitCurrencyState extends CurrencyState {}

class EmptyCurrencyState extends CurrencyState {
  final List<Currency> allCurrencies;

  EmptyCurrencyState({
    required this.allCurrencies,
  });
}

class CurrencyInSelectedState extends CurrencyState {
  final List<Currency> allCurrencies;
  final List<Currency> availableCurrenciesOut;
  final Currency currencyIn;

  CurrencyInSelectedState({
    required this.allCurrencies,
    required this.availableCurrenciesOut,
    required this.currencyIn,
  });
}

class CurrencyOutSelectedState extends CurrencyState {
  final List<Currency> allCurrencies;
  final List<Currency> availableCurrenciesIn;
  final Currency currencyOut;

  CurrencyOutSelectedState({
    required this.allCurrencies,
    required this.availableCurrenciesIn,
    required this.currencyOut,
  });
}

class SuccessCurrencyState extends CurrencyState {
  final List<Currency> availableCurrenciesOut;
  final List<Currency> availableCurrenciesIn;
  final Currency currencyOut;
  final Currency currencyIn;
  final bool canFlipCurrencies;

  SuccessCurrencyState({
    required this.availableCurrenciesOut,
    required this.availableCurrenciesIn,
    required this.currencyOut,
    required this.currencyIn,
    required this.canFlipCurrencies,
  });
}

class ErrorCurrencyState extends CurrencyState {
  final String title;
  final String message;

  ErrorCurrencyState({
    required this.title,
    required this.message,
  });
}
