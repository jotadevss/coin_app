import 'package:coin_app/app/interactor/entities/quote.dart';

class QuoteDetails {
  final Quote quote;
  final String currencies;
  final double pctChange;
  final double varBid;
  final double high;
  final double low;

  QuoteDetails({
    required this.quote,
    required this.currencies,
    required this.pctChange,
    required this.varBid,
    required this.high,
    required this.low,
  });
}
