import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/atoms/currency_atoms.dart';
import 'package:coin_app/app/interactor/atoms/quote_atoms.dart';
import 'package:coin_app/app/interactor/atoms/shared_atoms.dart';
import 'package:coin_app/app/interactor/contracts/repositories/quote_repository.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/states/currency_state.dart';
import 'package:coin_app/app/interactor/states/quote_state.dart';

class QuoteReducer extends Reducer {
  final IQuoteRepository quoteRepository;

  QuoteReducer({required this.quoteRepository}) {
    on(() => [fetchQuoteAction], _fetchQuote);
    on(() => [changeValueQuoteAction], _changeQuoteValue);
  }

  Future<void> _fetchQuote() async {
    isLoadingState.setValue(true);
    final stateCurrency = currencyState.value;

    if (stateCurrency is SuccessCurrencyState) {
      final code = "${stateCurrency.currencyIn.code}-${stateCurrency.currencyOut.code}";
      final combination = Combination(code: code, codeIn: stateCurrency.currencyIn.code, codeOut: stateCurrency.currencyOut.code);
      final quote = await quoteRepository.getQuote(combination);
      final newState = ShowQuoteState(quoteValue: quote.value * 1, quoteValueReference: quote.value * 1);
      quoteState.setValue(newState);
    }

    isLoadingState.setValue(false);
  }

  void _changeQuoteValue() {
    final value = changeValueQuoteAction.value;
    final currentState = quoteState.value;

    if (currentState is ShowQuoteState) {
      final newQuoteValue = currentState.quoteValue * value;
      final newState = ShowQuoteState(quoteValue: newQuoteValue, quoteValueReference: currentState.quoteValueReference);
      quoteState.setValue(newState);
    }
  }
}
