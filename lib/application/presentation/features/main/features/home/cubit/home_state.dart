part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.count = 0, this.cryptocurrencyList});

  final int count;
  final List<CryptocurrencyEntity>? cryptocurrencyList;

  @override
  List<Object?> get props => [count, cryptocurrencyList];

  HomeState copyWith({
    final int? count,
    final List<CryptocurrencyEntity>? cryptocurrencyList,
  }) =>
      HomeState(
        count: count ?? this.count,
        cryptocurrencyList: cryptocurrencyList ?? this.cryptocurrencyList,
      );
}
