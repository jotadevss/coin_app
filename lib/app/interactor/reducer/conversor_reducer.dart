import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/actions/conversor_actions.dart';
import 'package:coin_app/app/interactor/atoms/conversor_atoms.dart';
import 'package:coin_app/app/interactor/contracts/repositories/combination_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/currencies_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/quote_repository.dart';
import 'package:coin_app/app/interactor/enums/code_type.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/interactor/states/conversor_state.dart';
import 'package:coin_app/app/shared/formatters/currency_formatter.dart';

class ConversorReducer extends Reducer {
  final IQuoteRepository quoteRepository;
  final ICombinationRepository combinationRepository;
  final ICurrencyRepository currencyRepository;

  static final Combination _defaultCombination = Combination(code: "USD-BRL", codeIn: "USD", codeOut: "BRL");

  ConversorReducer({
    required this.quoteRepository,
    required this.combinationRepository,
    required this.currencyRepository,
  }) {
    on(() => [conversorAction], () {
      final action = conversorAction.value;

      switch (action) {
        case FetchAllCurrenciesAction1 _:
          _fetchAllCurrencies();
        case SetDefaultValuesAction _:
          _setDefaultValues();
        case ChangeCurrencyInAction c:
          _changeCurrency(c.currencyIn, CodeType.codeIn);
        case ChangeCurrencyOutAction c:
          _changeCurrency(c.currencyOut, CodeType.codeOut);
        case ChangeInputValueRateAction c:
          _changeInputValueRate(c.valueFormatted);
        case SearchCurrencyByInputAction c:
          _searchByInputCurrency(c.input, c.currencies);
        case FlipCurrenciesAction _:
          _flipCurrencies();
          break;
        default:
      }
    });
  }

  void _searchByInputCurrency(String input, List<Currency> currencies) {
    if (input.isEmpty) filteredCurrencyBySearchInputState.setValue([]);
    final filteredCurrencies = <Currency>[];
    for (var currency in currencies) {
      final code = currency.code.toLowerCase();
      final name = currency.name.toLowerCase();
      if (code.contains(input) || name.contains(input)) {
        filteredCurrencies.add(currency);
      }
    }
    filteredCurrencyBySearchInputState.setValue(filteredCurrencies);
  }

  void _changeInputValueRate(String valueFormatted) {
    final state = conversorState.value;

    if (state is SuccessConversorState) {
      double value = 0;
      if (valueFormatted.isNotEmpty) value = CurrencyFormatter.unformat(valueFormatted);

      final newRateValue = (state.rate * value);

      final newState = SuccessConversorState(
        allCurrencies: allCurrencies,
        currencyIn: state.currencyIn,
        currencyOut: state.currencyOut,
        rateValue: newRateValue,
        rate: state.rate,
      );

      conversorState.setValue(newState);
    }
  }

  void _fetchAllCurrencies() async {
    try {
      conversorState.setValue(LoadingConversorState());
      final currencies = await currencyRepository.getAllCurrencies();
      allCurrenciesState.setValue(currencies);
      conversorAction.setValue(SetDefaultValuesAction());
    } catch (e) {
      conversorState.setValue(
        ErrorConversorState(
          title: "Error inesperado",
          message: "Não conseguimos carregar todas as moedas, porfavor tente novamente.",
        ),
      );
    }
  }

  void _flipCurrencies() async {
    final state = conversorState.value;

    if (state is SuccessConversorState) {
      conversorState.setValue(LoadingConversorState());

      final combination = Combination(
        code: "${state.currencyOut.code}-${state.currencyIn.code}",
        codeIn: state.currencyOut.code,
        codeOut: state.currencyIn.code,
      );

      final hasCombination = await combinationRepository.hasCombination(combination);

      if (!hasCombination) {
        conversorState.setValue(
          ErrorConversorState(
            title: "Cotação Indiponível",
            message: "Não foi possível calcular o valor do câmbio de ${combination.codeIn}/${combination.codeOut}",
          ),
        );
        return;
      }

      final newRate = 1 / (state.rate);
      final newRateValue = (state.rateValue / state.rate) * newRate;

      final newState = SuccessConversorState(
        allCurrencies: allCurrencies,
        currencyIn: state.currencyOut,
        currencyOut: state.currencyIn,
        rateValue: newRateValue,
        rate: newRate,
      );

      conversorState.setValue(newState);
    }
  }

  void _setDefaultValues() async {
    try {
      conversorState.setValue(LoadingConversorState());

      final currencyIn = allCurrencies.firstWhere((c) => c.code == _defaultCombination.codeIn);
      final currencyOut = allCurrencies.firstWhere((c) => c.code == _defaultCombination.codeOut);
      final quote = await quoteRepository.getQuote(_defaultCombination);
      final rate = quote.value;

      final newState = SuccessConversorState(
        allCurrencies: allCurrencies,
        currencyIn: currencyIn,
        currencyOut: currencyOut,
        rateValue: rate,
        rate: rate * 1,
      );

      conversorState.setValue(newState);
    } catch (e) {
      conversorState.setValue(
        ErrorConversorState(
          title: "Error inesperado",
          message: "Não conseguimos carregar todas as moedas, porfavor tente novamente.",
        ),
      );
    }
  }

  void _changeCurrency(Currency currency, CodeType codeType) async {
    final state = conversorState.value;

    if (state is SuccessConversorState) {
      final SuccessConversorState previousState = state;
      conversorState.setValue(LoadingConversorState());

      late Combination combination;

      if (state.currencyIn.code == currency.code || state.currencyOut.code == currency.code) {
        conversorState.setValue(previousState);
      }

      if (codeType == CodeType.codeIn) {
        combination = Combination(
          code: "${currency.code}-${state.currencyOut.code}",
          codeIn: currency.code,
          codeOut: state.currencyOut.code,
        );
      }

      if (codeType == CodeType.codeOut) {
        combination = Combination(
          code: "${state.currencyIn.code}-${currency.code}",
          codeIn: state.currencyIn.code,
          codeOut: currency.code,
        );
      }

      try {
        final hasCombination = await combinationRepository.hasCombination(combination);

        if (!hasCombination) {
          conversorState.setValue(
            ErrorConversorState(
              title: "Cotação Indiponível",
              message: "Não foi possível calcular o valor do câmbio de ${combination.codeIn}/${combination.codeOut}",
            ),
          );
          return;
        }

        final quote = await quoteRepository.getQuote(combination);
        final rateValue = inputValueState.value * quote.value;
        final rate = quote.value * 1;

        late SuccessConversorState newState;

        if (codeType == CodeType.codeIn) {
          newState = SuccessConversorState(
            allCurrencies: allCurrencies,
            currencyIn: currency,
            currencyOut: state.currencyOut,
            rateValue: rateValue,
            rate: rate,
          );
        }

        if (codeType == CodeType.codeOut) {
          newState = SuccessConversorState(
            allCurrencies: allCurrencies,
            currencyIn: state.currencyIn,
            currencyOut: currency,
            rateValue: rateValue,
            rate: rate,
          );
        }

        conversorState.setValue(newState);
      } catch (e) {
        conversorState.setValue(
          ErrorConversorState(
            title: "Cotação Indiponível",
            message: "Não foi possível calcular o valor do câmbio de ${combination.codeIn}/${combination.codeOut}",
          ),
        );
      }
    }
  }
}
