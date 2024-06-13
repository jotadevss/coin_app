import 'dart:convert';

import 'package:coin_app/app/interactor/models/quote.dart';

class QuoteAdapter {
  static Quote fromMap(Map<String, dynamic> map) {
    return Quote(
      codes: "${map['code'] as String}-${map['codein'] as String}",
      currencies: map['name'] as String,
      value: double.parse(map['bid'] as String),
      pctChange: double.parse(map['pctChange'] as String),
      varBid: double.parse(map['varBid'] as String),
      high: double.parse(map['high'] as String),
      low: double.parse(map['low'] as String),
    );
  }

  static Quote fromJson(String source) => fromMap(jsonDecode(source) as Map<String, dynamic>);
}
