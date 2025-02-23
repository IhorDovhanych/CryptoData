import 'package:crypto_data/application/data/datasources/price_chart_datasource.dart';
import 'package:crypto_data/application/data/mapper/price_chart_mapper.dart';
import 'package:crypto_data/application/data/models/price_chart_model.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
import 'package:crypto_data/application/domain/repository/price_chart_repository.dart';
import 'package:crypto_data/core/error/base_exception.dart';
import 'package:crypto_data/core/error/error_codes.dart';
import 'package:crypto_data/core/utils/print_utils.dart';
import 'package:dartz/dartz.dart';

class PriceChartRepositoryImpl implements PriceChartRepository {
  PriceChartRepositoryImpl(this._priceChartDatasource);

  final PriceChartDatasource _priceChartDatasource;

  @override
  Future<Either<BaseException, PriceChartEntity>> getPriceChart(
      final String id, final int days) async {
    try {
      final PriceChartModel model = await _priceChartDatasource.getPriceChart(id, days);
      final PriceChartEntity entity = model.toEntity;
      return Right(entity);
    } catch (e, st) {
      const message = 'Failed to getPagginatedCryptocurrencyList';
      printError(message, e, st);
      return Left(
          BaseException(error: e, stack: st, code: ecNonDio, message: message));
    }
  }
}
