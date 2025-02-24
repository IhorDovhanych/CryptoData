part of 'detail_cubit.dart';

class DetailState extends Equatable {
  const DetailState({this.cryptocurrency, this.priceChart, this.days});

  final CryptocurrencyEntity? cryptocurrency;
  final PriceChartEntity? priceChart;
  final int? days;

  @override
  List<Object?> get props => [cryptocurrency, priceChart, days];

  DetailState copyWith({
  final CryptocurrencyEntity? cryptocurrency,
  final PriceChartEntity? priceChart,
  final int? days,
  }) =>
      DetailState(
        cryptocurrency: cryptocurrency ?? this.cryptocurrency,
        priceChart: priceChart ?? this.priceChart,
        days: days ?? this.days
      );
}
