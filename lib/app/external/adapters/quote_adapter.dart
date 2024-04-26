import 'dart:convert';

import 'package:coin_app/app/interactor/models/quote.dart';

class QuoteAdapter {
  static Quote fromMap(Map<String, dynamic> map) {
    return Quote(
      codes: map['code'] as String,
      currencies: map['name'],
      value: double.parse(map['bid']),
      pctChange: double.parse(map['pctChange']),
      varBid: double.parse(map['varBid']),
      high: double.parse(map['high']),
      low: double.parse(map['low']),
    );
  }

  static Quote fromJson(String source) => fromMap(jsonDecode(source) as Map<String, dynamic>);
}
