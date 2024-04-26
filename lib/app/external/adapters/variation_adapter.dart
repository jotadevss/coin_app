import 'dart:convert';

import 'package:coin_app/app/interactor/models/variation.dart';

class VariationAdapter {
  static Variation fromMap(Map<String, dynamic> map) {
    return Variation(
      code: map['code'].toString(),
      codeIn: map['codein'].toString(),
      value: double.parse(map['bid']),
      pctChange: double.parse(map['pctChange']),
      date: DateTime.fromMillisecondsSinceEpoch(int.parse(map['timestamp']) * 1000),
    );
  }

  static Variation fromJson(String source) => fromMap(jsonDecode(source) as Map<String, dynamic>);
}
