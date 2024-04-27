import 'package:coin_app/app/external/adapters/combination_adapter.dart';
import 'package:coin_app/app/interactor/contracts/repositories/combination_repository.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/shared/constants/constants.dart';

class LocalCombinationRepository implements ICombinationRepository {
  @override
  Future<List<Combination>> getAllCombinations() async {
    try {
      const combinationsList = AppConstants.combinations;
      final List<Combination> combinations = CombinationAdapter.fromListString(combinationsList);
      return combinations;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Combination>> getByCodeIn(String codeIn) async {
    try {
      const combinationsList = AppConstants.combinations;
      final List<Combination> combinations = CombinationAdapter.fromListString(combinationsList);
      return combinations.where((c) => c.codeIn == codeIn).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Combination>> getByCodeOut(String codeOut) async {
    try {
      const combinationsList = AppConstants.combinations;
      final List<Combination> combinations = CombinationAdapter.fromListString(combinationsList);
      return combinations.where((c) => c.codeOut == codeOut).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> hasCombination(Combination combination) async {
    try {
      const combinationsList = AppConstants.combinations;
      final List<Combination> combinations = CombinationAdapter.fromListString(combinationsList);
      final result = combinations.where((e) => e.code == combination.code).toList();
      return (result.isEmpty) ? false : true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
