// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coin_app/app/interactor/models/currency.dart';

sealed class ConversorState {
  T? when<T>({
    required T? Function(InitConversorState state) init,
    required T? Function(SuccessConversorState state) success,
    required T? Function(LoadingConversorState state) loading,
    required T? Function(ErrorConversorState state) error,
  }) {
    return switch (this) {
      InitConversorState s => init(s),
      SuccessConversorState s => success(s),
      LoadingConversorState s => loading(s),
      ErrorConversorState s => error(s),
    };
  }
}

class InitConversorState extends ConversorState {}

class SuccessConversorState extends ConversorState {
  final List<Currency> allCurrencies;
  final Currency currencyIn;
  final Currency currencyOut;
  final double rateValue;
  final double rate;

  SuccessConversorState({
    required this.allCurrencies,
    required this.currencyIn,
    required this.currencyOut,
    required this.rateValue,
    required this.rate,
  });
}

class LoadingConversorState extends ConversorState {}

class ErrorConversorState extends ConversorState {
  final String title;
  final String message;

  ErrorConversorState({
    required this.title,
    required this.message,
  });
}
