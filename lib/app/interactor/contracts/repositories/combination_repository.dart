import 'package:coin_app/app/interactor/models/combination.dart';

abstract class ICombinationRepository {
  Future<List<Combination>> getAllCombinations();
  Future<List<Combination>> getByCodeIn(String codeIn);
  Future<List<Combination>> getByCodeOut(String codeOut);
  Future<bool> hasCombination(Combination combination);
}
