import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/atoms/currency_atoms.dart';
import 'package:coin_app/app/interactor/contracts/repositories/combination_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/currencies_repository.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/interactor/states/currency_state.dart';

enum CodeType { codeIn, codeOut }

class CurrencyReducer extends Reducer {
  final ICurrencyRepository currencyRepository;
  final ICombinationRepository combinationRepository;

  CurrencyReducer({required this.combinationRepository, required this.currencyRepository}) {
    on(() => [fetchAllCurrenciesAction], _fetchAllCurrencies);
    on(() => [selectCurrencyInAction], _selectCurrencyIn);
    on(() => [selectCurrencyOutAction], _selectCurrencyOut);
    on(() => [flipCurrenciesAction], _flipCurrencies);
    on(() => [clearCurrencyInAction], _clearCurrencyIn);
    on(() => [clearCurrencyOutAction], _clearCurrencyOut);
    on(() => [clearAllCurrenciesAction], _clearAllCurrencies);
  }

  Future<void> _fetchAllCurrencies() async {
    final currencies = await currencyRepository.getAllCurrencies();
    currencyState.setValue(EmptyCurrencyState(allCurrencies: currencies));
  }

  Future<void> _selectCurrencyIn() async {
    final Currency selectedCurrency = selectCurrencyInAction.value!;
    final CurrencyState currentState = currencyState.value;
    final newState = await _handlerCurrencyInSelection(selectedCurrency, currentState);
    currencyState.setValue(newState);
  }

  Future<void> _selectCurrencyOut() async {
    final Currency selectedCurrency = selectCurrencyInAction.value!;
    final CurrencyState currentState = currencyState.value;
    final newState = await _handlerCurrencyOutSelection(selectedCurrency, currentState);
    currencyState.setValue(newState);
  }

  void _flipCurrencies() {
    final CurrencyState currentState = currencyState.value;

    if (currentState is SuccessCurrencyState && currentState.canFlipCurrencies) {
      final newState = SuccessCurrencyState(
        availableCurrenciesOut: currentState.availableCurrenciesIn,
        availableCurrenciesIn: currentState.availableCurrenciesOut,
        currencyOut: currentState.currencyIn,
        currencyIn: currentState.currencyOut,
        canFlipCurrencies: currentState.canFlipCurrencies,
      );

      currencyState.setValue(newState);
    }
  }

  Future<void> _clearCurrencyIn() async {
    final CurrencyState currentState = currencyState.value;
    final newState = await _handlerClearCurrencyIn(currentState);
    currencyState.setValue(newState);
  }

  Future<void> _clearCurrencyOut() async {
    final CurrencyState currentState = currencyState.value;
    final newState = await _handlerClearCurrencyOut(currentState);
    currencyState.setValue(newState);
  }

  Future<void> _clearAllCurrencies() async {
    final CurrencyState currentState = currencyState.value;
    final newState = await _handleClearCurrencies(currentState);
    currencyState.setValue(newState);
  }

  Future<CurrencyState> _handleClearCurrencies(CurrencyState currentState) async {
    late CurrencyState state;

    if (currentState is SuccessCurrencyState) {
      final currencies = await currencyRepository.getAllCurrencies();
      final newState = EmptyCurrencyState(allCurrencies: currencies);
      state = newState;
    }

    return state;
  }

  Future<CurrencyState> _handlerClearCurrencyIn(CurrencyState currentState) async {
    late CurrencyState state;

    if (currentState is SuccessCurrencyState) {
      final allCurrencies = await currencyRepository.getAllCurrencies();
      final newState = CurrencyOutSelectedState(
        availableCurrenciesIn: currentState.availableCurrenciesIn,
        currencyOut: currentState.currencyOut,
        allCurrencies: allCurrencies,
      );
      state = newState;
    }

    if (currentState is CurrencyInSelectedState) {
      final currencies = await currencyRepository.getAllCurrencies();
      final newState = EmptyCurrencyState(allCurrencies: currencies);
      state = newState;
    }

    return state;
  }

  Future<CurrencyState> _handlerClearCurrencyOut(CurrencyState currentState) async {
    late CurrencyState state;

    if (currentState is SuccessCurrencyState) {
      final allCurrencies = await currencyRepository.getAllCurrencies();
      final newState = CurrencyInSelectedState(
        availableCurrenciesOut: currentState.availableCurrenciesOut,
        currencyIn: currentState.currencyIn,
        allCurrencies: allCurrencies,
      );
      state = newState;
    }

    if (currentState is CurrencyOutSelectedState) {
      final currencies = await currencyRepository.getAllCurrencies();
      final newState = EmptyCurrencyState(allCurrencies: currencies);
      state = newState;
    }

    return state;
  }

  Future<CurrencyState> _handlerCurrencyInSelection(Currency selectedCurrency, CurrencyState currentState) async {
    late CurrencyState state;

    if (currentState is EmptyCurrencyState || currentState is CurrencyInSelectedState) {
      final codeOuts = await _getCodeByCurrency(CodeType.codeOut, selectedCurrency);
      final currenciesOut = await _getCurrenciesByCode(CodeType.codeOut, codeOuts);
      final allCurrencies = await currencyRepository.getAllCurrencies();
      final newState = CurrencyInSelectedState(availableCurrenciesOut: currenciesOut, currencyIn: selectedCurrency, allCurrencies: allCurrencies);
      state = newState;
    }

    if (currentState is CurrencyOutSelectedState) {
      final codeOuts = await _getCodeByCurrency(CodeType.codeOut, selectedCurrency);
      final currenciesOut = await _getCurrenciesByCode(CodeType.codeOut, codeOuts);
      final canFlipCurrencies = await _checkCanFlipCurrencies(selectedCurrency, currentState.currencyOut);

      final newState = SuccessCurrencyState(
        availableCurrenciesOut: currenciesOut,
        availableCurrenciesIn: currentState.availableCurrenciesIn,
        currencyOut: currentState.currencyOut,
        currencyIn: selectedCurrency,
        canFlipCurrencies: canFlipCurrencies,
      );

      state = newState;
    }

    if (currentState is SuccessCurrencyState) {
      final newState = SuccessCurrencyState(
        availableCurrenciesOut: currentState.availableCurrenciesOut,
        availableCurrenciesIn: currentState.availableCurrenciesIn,
        currencyOut: currentState.currencyOut,
        currencyIn: currentState.currencyIn,
        canFlipCurrencies: currentState.canFlipCurrencies,
      );

      state = newState;
    }

    return state;
  }

  Future<CurrencyState> _handlerCurrencyOutSelection(Currency selectedCurrency, CurrencyState currentState) async {
    late CurrencyState state;

    if (currentState is EmptyCurrencyState || currentState is CurrencyOutSelectedState) {
      final codeIns = await _getCodeByCurrency(CodeType.codeIn, selectedCurrency);
      final currenciesIns = await _getCurrenciesByCode(CodeType.codeIn, codeIns);
      final allCurrencies = await currencyRepository.getAllCurrencies();

      final newState = CurrencyOutSelectedState(availableCurrenciesIn: currenciesIns, currencyOut: selectedCurrency, allCurrencies: allCurrencies);
      state = newState;
    }

    if (currentState is CurrencyOutSelectedState) {
      final codeOuts = await _getCodeByCurrency(CodeType.codeIn, selectedCurrency);
      final currenciesOut = await _getCurrenciesByCode(CodeType.codeIn, codeOuts);
      final canFlipCurrencies = await _checkCanFlipCurrencies(selectedCurrency, currentState.currencyOut);

      final newState = SuccessCurrencyState(
        availableCurrenciesOut: currenciesOut,
        availableCurrenciesIn: currentState.availableCurrenciesIn,
        currencyOut: currentState.currencyOut,
        currencyIn: selectedCurrency,
        canFlipCurrencies: canFlipCurrencies,
      );

      state = newState;
    }

    if (currentState is SuccessCurrencyState) {
      final newState = SuccessCurrencyState(
        availableCurrenciesOut: currentState.availableCurrenciesOut,
        availableCurrenciesIn: currentState.availableCurrenciesIn,
        currencyOut: currentState.currencyOut,
        currencyIn: currentState.currencyIn,
        canFlipCurrencies: currentState.canFlipCurrencies,
      );

      state = newState;
    }

    return state;
  }

  Future<bool> _checkCanFlipCurrencies(Currency currencyIn, Currency currencyOut) async {
    final codeReversedCombination = "${currencyOut.code}-${currencyIn.code}";
    final reversedCombination = Combination(code: codeReversedCombination, codeIn: currencyOut.code, codeOut: currencyIn.code);
    final canFlipCurrencies = await combinationRepository.hasCombination(reversedCombination);
    return canFlipCurrencies;
  }

  Future<List<Currency>> _getCurrenciesByCode(CodeType codeType, List<String> codes) async {
    final List<Currency> currencies = [];

    if (codeType == CodeType.codeOut) {
      for (var codeOut in codes) {
        currencies.add(await currencyRepository.getByCodeOut(codeOut));
      }
    }

    if (codeType == CodeType.codeIn) {
      for (var codeIn in codes) {
        currencies.add(await currencyRepository.getByCodeIn(codeIn));
      }
    }

    return currencies;
  }

  Future<List<String>> _getCodeByCurrency(CodeType codeType, Currency currency) async {
    List<String> codes = [];

    if (codeType == CodeType.codeIn) {
      final availableCombinations = await combinationRepository.getByCodeIn(currency.code);
      final availableCodeIn = availableCombinations.map((e) => e.codeIn).toList();
      codes = availableCodeIn;
    }

    if (codeType == CodeType.codeOut) {
      final availableCombinations = await combinationRepository.getByCodeIn(currency.code);
      final availableCodeOuts = availableCombinations.map((e) => e.codeOut).toList();
      codes = availableCodeOuts;
    }

    return codes;
  }
}
