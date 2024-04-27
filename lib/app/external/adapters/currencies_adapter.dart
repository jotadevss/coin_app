import 'package:coin_app/app/interactor/models/currency.dart';

class CurrencyAdapter {
  static List<Currency> fromMap(Map<String, dynamic> map) {
    final List<Currency> currencylist = [];

    map.forEach((code, name) {
      currencylist.add(Currency(
        code: code,
        name: name,
        flagUrl: "assets/flags/${code.toLowerCase()}",
      ));
    });

    return currencylist;
  }
}
