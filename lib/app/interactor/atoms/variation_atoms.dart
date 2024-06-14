import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/actions/variation_actions.dart';
import 'package:coin_app/app/interactor/models/variation.dart';
import 'package:coin_app/app/interactor/states/variation_state.dart';
import 'package:coin_app/app/shared/extensions/extensions.dart';

final variationState$ = Atom<VariationState>(LoadingVariationState());
final variationsByDaysState$ = Atom<List<Variation>>([]);

List<Variation> get reversedVariations {
  if (variationsByDaysState$.value.isEmpty) return [];
  final values = variationsByDaysState$.value.reversed.toList();
  return values;
}

List<double> get valuesVariationToChart {
  if (variationsByDaysState$.value.isEmpty) return [];

  final values = reversedVariations.map((e) => e.value).toList();
  final slicedValues = values.interval(4);
  return slicedValues;
}

List<double> get valuesInRangeToChart {
  if (variationsByDaysState$.value.isEmpty && valuesVariationToChart.isEmpty) return [];

  final values = reversedVariations.map((e) => e.value).toList();
  final mapRangePoint = valuesVariationToChart.consecutivePointRangeMap();
  final valuesRange = mapRangePoint.mapValuesToPoints(values);
  return valuesRange;
}

final variationAction = Atom<VariationAction?>(null);
