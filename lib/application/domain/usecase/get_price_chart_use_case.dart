import 'package:crypto_data/application/domain/core/use_case.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
import 'package:crypto_data/application/domain/repository/price_chart_repository.dart';
import 'package:crypto_data/core/error/base_exception.dart';
import 'package:dartz/dartz.dart';

class GetPriceChartUseCase
    extends AsyncUseCase<Tuple2<String, int>, PriceChartEntity> {
  const GetPriceChartUseCase(this._priceChartRepository);

  final PriceChartRepository _priceChartRepository;

  @override
  Future<Either<BaseException, PriceChartEntity>> call(
      final Tuple2<String, int> params) async {
    final String id = params.value1;
    final int days = params.value2;
    return _priceChartRepository.getPriceChart(id, days);
  }
}
