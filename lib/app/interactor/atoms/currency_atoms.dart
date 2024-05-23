import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/interactor/states/currency_state.dart';

// States
final currencyState = Atom<CurrencyState>(InitCurrencyState());
final inputSearchCurrencyText = Atom<String>("");
final searchCurrencyResultState = Atom<List<Currency>>([]);

// Actions
final fetchAllCurrenciesAction = Atom.action();
final selectCurrencyInAction = Atom<Currency?>(null);
final selectCurrencyOutAction = Atom<Currency?>(null);
final flipCurrenciesAction = Atom.action();
final clearCurrencyInAction = Atom.action();
final clearCurrencyOutAction = Atom.action();
final clearAllCurrenciesAction = Atom.action();
final filterCurrencyStringSearchAction = Atom<List<Currency>>([]);
