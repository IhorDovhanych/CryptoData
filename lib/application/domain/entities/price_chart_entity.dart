import 'package:equatable/equatable.dart';

class PriceChartEntity extends Equatable {
  const PriceChartEntity({
    required this.id,
    required this.days,
    required this.priceChart,
  });

  factory PriceChartEntity.fromJson(final Map<String, dynamic> json) =>
      PriceChartEntity(
        id: json['id'] as String,
        days: json['days'] as int,
        priceChart: List<double>.from(json['price_chart'] as List<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'days': days,
        'price_chart': priceChart,
      };

  PriceChartEntity copyWith({
    final String? id,
    final int? days,
    final List<double>? priceChart,
  }) =>
      PriceChartEntity(
        id: id ?? this.id,
        days: days ?? this.days,
        priceChart: priceChart ?? this.priceChart,
      );

  @override
  List<Object?> get props => [id, days, priceChart];

  final String id;
  final int days;
  final List<double> priceChart;
}
