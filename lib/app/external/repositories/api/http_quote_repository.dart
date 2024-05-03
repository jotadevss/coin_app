import 'dart:convert';

import 'package:coin_app/app/external/adapters/quote_adapter.dart';
import 'package:coin_app/app/interactor/contracts/repositories/quote_repository.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/models/quote.dart';
import 'package:http/http.dart' as http;

class HttpQuoteRepository implements IQuoteRepository {
  final _client = http.Client();
  final _baseUrl = "https://economia.awesomeapi.com.br/last/";

  @override
  Future<List<Quote>> getAllQuotes(List<Combination> combinations) async {
    try {
      final params = combinations //
          .map((e) => e.code)
          .toList()
          .join(',');

      final response = await _client.get(Uri.parse("$_baseUrl$params"));
      final map = jsonDecode(response.body) as Map<String, dynamic>;

      final quotes = map // Convert Map to Quote Object
          .entries
          .map((c) => QuoteAdapter.fromMap(c.value))
          .toList();

      return quotes;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Quote> getQuote(Combination combination) async {
    try {
      final params = combination.code;
      final response = await _client.get(Uri.parse("$_baseUrl$params"));
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final quote = QuoteAdapter.fromMap(map);
      return quote;
    } catch (e) {
      throw Exception(e);
    }
  }
}
