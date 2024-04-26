import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/models/variation.dart';

abstract class IVariationRepository {
  Future<List<Variation>> getLastVariations(int lastDays, Combination combination);
}
