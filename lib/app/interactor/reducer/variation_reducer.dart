import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/actions/variation_actions.dart';
import 'package:coin_app/app/interactor/atoms/variation_atoms.dart';
import 'package:coin_app/app/interactor/contracts/repositories/combination_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/variation_repository.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/states/variation_state.dart';

class VariationReducer extends Reducer {
  final ICombinationRepository combinationRepository;
  final IVariationRepository variationRepository;

  VariationReducer({
    required this.combinationRepository,
    required this.variationRepository,
  }) {
    on(() => [variationAction], () {
      final action = variationAction.value!;

      switch (action) {
        case FetchVariationsByDaysAction c:
          _fetchVariationsByDays(c.days, c.combination);
          break;
        default:
      }
    });
  }

  void _fetchVariationsByDays(int days, Combination combination) async {
    variationState$.setValue(LoadingVariationState());

    try {
      final hasCombination = await combinationRepository.hasCombination(combination);

      if (!hasCombination) {
        variationState$.setValue(ErrorVariationState());
      }

      final variations = await variationRepository.getLastVariations(days, combination);

      variationsByDaysState$.setValue(variations);
      variationState$.setValue(SuccessVariationState());
    } catch (e) {
      variationState$.setValue(ErrorVariationState());
    }
  }
}
