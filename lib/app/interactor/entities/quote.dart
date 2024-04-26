class Quote {
  final String combinationCode;
  final double value;
  final double pctChange;
  final double varBid;
  final double high;
  final double low;

  Quote({
    required this.combinationCode,
    required this.value,
    required this.pctChange,
    required this.varBid,
    required this.high,
    required this.low,
  });
}
