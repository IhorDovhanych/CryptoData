import 'package:crypto_data/application/di/injections.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
import 'package:crypto_data/application/domain/usecase/get_pagginated_cryptocurrency_list_use_case.dart';
import 'package:crypto_data/application/domain/usecase/get_price_chart_use_case.dart';
import 'package:crypto_data/core/cubit/cubit_base.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'detail_state.dart';

class DetailCubit extends CubitBase<DetailState> {
  DetailCubit() : super(const DetailState());

  final GetPriceChartUseCase _getPriceChartUseCase =
      getIt<GetPriceChartUseCase>();

  Future<void> getPriceChart(final String id, final int days) async {
    try {
      final result =
          await executeAsync(_getPriceChartUseCase.call(Tuple2(id, days)));
      result.fold(
        (final l) => throw Exception(l),
        (final r) {
          emit(state.copyWith(priceChart: r, days: days));
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
