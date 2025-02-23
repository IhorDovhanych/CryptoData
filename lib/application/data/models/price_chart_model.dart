import 'package:flutter/cupertino.dart';

@immutable
class PriceChartModel {

  const PriceChartModel({
    required this.id,
    required this.days,
    required this.priceChart,
  });

  factory PriceChartModel.fromJson(final Map<String, dynamic> json) => PriceChartModel(
      id: json['id'] as String,
      days: json['days'] as int,
      priceChart: List<double>.from(json['price_chart'] as List<dynamic>),
    );

  final String id;
  final int days;
  final List<double> priceChart;

    Map<String, dynamic> toJson() => {
      'id': id,
      'days': days,
      'price_chart': priceChart,
    };
}
