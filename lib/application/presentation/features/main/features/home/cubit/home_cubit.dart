import 'package:crypto_data/application/di/injections.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/entities/price_chart_entity.dart';
import 'package:crypto_data/application/domain/usecase/get_pagginated_cryptocurrency_list_use_case.dart';
import 'package:crypto_data/application/domain/usecase/get_price_chart_use_case.dart';
import 'package:crypto_data/core/cubit/cubit_base.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends CubitBase<HomeState> {

  HomeCubit() : super(const HomeState());

  final GetPagginatedCryptocurrencyListUseCase _getPagginatedCryptocurrencyListUseCase = getIt<GetPagginatedCryptocurrencyListUseCase>();
  final GetPriceChartUseCase _getPriceChartUseCase = getIt<GetPriceChartUseCase>();

  void countIncrement() {
    emit(state.copyWith(count: state.count + 1));
  }

  Future<void> getPagginatedCryptocurrencyList(final int page, final int amountPerPage, final String vsCurrency) async{
    try {
      final result = await executeAsync(_getPagginatedCryptocurrencyListUseCase.call(Tuple3(page, amountPerPage, vsCurrency)));
      result.fold(
        (final l) => throw Exception(l),
        (final r) => emit(state.copyWith(
          cryptocurrencyList: r,
        )
      ));
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future<PriceChartEntity> getPriceChart(final String id, final int days) async {
    try {
      final result = await executeAsync(_getPriceChartUseCase.call(Tuple2(id, days)));
      return result.fold(
        (final l) => throw Exception(l),
        (final r) => r,
      );
    }
    catch (e) {
      throw Exception(e);
    }
  }
}