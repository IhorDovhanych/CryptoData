import 'package:crypto_data/application/data/models/price_chart_model.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';

extension PriceChartEntityX on PriceChartEntity {
  PriceChartModel get toModel => PriceChartModel(
        id: id,
        days: days,
        priceChart: priceChart,
      );
}

extension PriceChartX on PriceChartModel {
  PriceChartEntity get toEntity => PriceChartEntity(
        id: id,
        days: days,
        priceChart: priceChart,
      );
}