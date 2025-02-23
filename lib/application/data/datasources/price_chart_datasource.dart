import 'dart:convert';

import 'package:crypto_data/application/data/models/price_chart_model.dart';
import 'package:http/http.dart' as http;

abstract class PriceChartDatasource {
    Future<PriceChartModel>
      getPriceChart(final String id, final int days);
}

class PriceChartDatasourceImpl implements PriceChartDatasource {
  PriceChartDatasourceImpl();

  @override
  Future<PriceChartModel> getPriceChart(final String id, final int days) async {
    final String url =
        'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=$days';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return PriceChartModel(
        id: id,
        days: days,
        priceChart: List<double>.from(
          (data['prices'] as List).map((final entry) => entry[1] as double),
        ),
      );
    } else {
      throw Exception('Failed to load price chart data');
    }
  }
}