import 'package:coin_app/app/interactor/models/combination.dart';

class CombinationAdapter {
  static List<Combination> fromListString(List<String> list) {
    final List<Combination> combinations = [];

    for (var code in list) {
      final codeParts = code.split("-");
      combinations.add(Combination(code: code, codeIn: codeParts[0], codeOut: codeParts[1]));
    }

    return combinations;
  }
}
