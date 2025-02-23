  import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
  import 'package:crypto_data/core/error/base_exception.dart';
  import 'package:dartz/dartz.dart';

  abstract class PriceChartRepository {
    Future<Either<BaseException, PriceChartEntity>>
        getPriceChart(final String id, final int days);
  }
