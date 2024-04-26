class Quote {
  final String codes;
  final String currencies;
  final double value;
  final double pctChange;
  final double varBid;
  final double high;
  final double low;

  Quote({
    required this.codes,
    required this.currencies,
    required this.value,
    required this.pctChange,
    required this.varBid,
    required this.high,
    required this.low,
  });
}
