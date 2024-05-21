import 'package:coin_app/app/interactor/models/currency.dart';

sealed class CurrencyState {
  T? when<T>({
    required T? Function(InitCurrencyState state) init,
    required T? Function(EmptyCurrencyState state) empty,
    required T? Function(CurrencyInSelectedState state) currencyIn,
    required T? Function(CurrencyOutSelectedState state) currencyOut,
    required T? Function(SuccessCurrencyState state) success,
    required T? Function(ErrorCurrencyState state) error,
  }) {
    return switch (this) {
      InitCurrencyState s => init(s),
      EmptyCurrencyState s => empty(s),
      CurrencyInSelectedState s => currencyIn(s),
      CurrencyOutSelectedState s => currencyOut(s),
      SuccessCurrencyState s => success(s),
      ErrorCurrencyState s => error(s),
    };
  }
}

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
