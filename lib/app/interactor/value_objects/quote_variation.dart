import 'package:coin_app/app/interactor/entities/quote.dart';

class QuoteVariation {
  final Quote quote;
  final double pctChange;
  final DateTime date;

  QuoteVariation({
    required this.quote,
    required this.pctChange,
    required this.date,
  });
}
