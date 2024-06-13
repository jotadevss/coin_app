import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/actions/conversor_actions.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/interactor/states/conversor_state.dart';

// States
final conversorState = Atom<ConversorState>(InitConversorState());
final allCurrenciesState = Atom<List<Currency>>([]);
final inputValueState = Atom<double>(1);
final filteredCurrencyBySearchInputState = Atom<List<Currency>>([]);

// Computed
List<Currency> get allCurrencies => allCurrenciesState.value;
List<Currency> get filttedCurrencyBySearch => filteredCurrencyBySearchInputState.value;

// Actions
final conversorAction = Atom<ConversorAction?>(null);
