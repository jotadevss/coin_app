sealed class QuoteState {}

class HideQuoteState extends QuoteState {}

class ShowQuoteState extends QuoteState {
  final double quoteValue;
  final double quoteValueReference;

  ShowQuoteState({required this.quoteValue, required this.quoteValueReference});
}
