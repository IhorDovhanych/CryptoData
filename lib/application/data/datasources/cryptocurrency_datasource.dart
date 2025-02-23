import 'dart:convert';

import 'package:crypto_data/application/data/models/cryptocurrency_model.dart';
import 'package:http/http.dart' as http;

abstract class CryptocurrencyDatasource {
  Future<List<CryptocurrencyModel>> getPagginatedCryptocurrencyList(
      final int page, final int amountPerPage,
      [final String vsCurrency = 'usd']);
}

class CryptocurrencyDatasourceImpl implements CryptocurrencyDatasource {
  CryptocurrencyDatasourceImpl();

  @override
  Future<List<CryptocurrencyModel>> getPagginatedCryptocurrencyList(
      [final int page = 1,
      final int amountPerPage = 10,
      final String vsCurrency = 'usd']) async {
    final String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$vsCurrency&order=market_cap_desc&per_page=$amountPerPage&page=$page';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((final json) => CryptocurrencyModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cryptocurrency data');
    }
  }
}
