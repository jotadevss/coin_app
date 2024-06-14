import 'package:coin_app/app/interactor/models/combination.dart';

sealed class VariationAction {}

class FetchVariationsByDaysAction extends VariationAction {
  final int days;
  final Combination combination;

  FetchVariationsByDaysAction({
    required this.days,
    required this.combination,
  });
}
