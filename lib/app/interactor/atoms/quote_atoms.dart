import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/states/quote_state.dart';

// atoms
final quoteState = Atom<QuoteState>(HideQuoteState());

// actions
final fetchQuoteAction = Atom.action();
final changeValueQuoteAction = Atom<double>(1);
