import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    newText = format(newText);

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }

  static String format(String text) {
    if (text.isNotEmpty) {
      final double value = double.parse(text) / 100;
      final formatter = NumberFormat("#,##0.00");
      text = formatter.format(value);
    }

    return text;
  }

  static String formatSimple(double text) {
    return NumberFormat.compactSimpleCurrency().format(text);
  }

  static double unformat(String text) {
    String newText = text.replaceAll(",", '');
    double result = double.parse(newText);
    return result;
  }
}
