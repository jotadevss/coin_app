import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/models/quote.dart';

abstract class IQuoteRepository {
  Future<List<Quote>> getAllQuotes(List<Combination> combinations);
  Future<Quote> getQuote(Combination combination);
}
