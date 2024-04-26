import 'dart:convert';
import 'package:coin_app/app/external/adapters/variation_adapter.dart';
import 'package:coin_app/app/interactor/contracts/repositories/variation_repository.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/models/variation.dart';
import 'package:http/http.dart' as http;

class HttpVariationRepository implements IVariationRepository {
  final _client = http.Client();
  final _baseUrl = "https://economia.awesomeapi.com.br/json/daily";

  @override
  Future<List<Variation>> getLastVariations(int lastDays, Combination pair) async {
    try {
      final params = "/${pair.code}/$lastDays";
      final response = await _client.get(Uri.parse("$_baseUrl$params"));
      final data = jsonDecode(response.body) as List<dynamic>;

      final variations = data //
          .map((e) => VariationAdapter.fromMap(e as Map<String, dynamic>))
          .toList();

      return variations;
    } catch (e) {
      throw Exception(e);
    }
  }
}
