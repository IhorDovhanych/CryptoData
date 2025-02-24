part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.cryptocurrencyList});

  final List<CryptocurrencyEntity>? cryptocurrencyList;

  @override
  List<Object?> get props => [cryptocurrencyList];

  HomeState copyWith({
    final List<CryptocurrencyEntity>? cryptocurrencyList,
  }) =>
      HomeState(
        cryptocurrencyList: cryptocurrencyList ?? this.cryptocurrencyList,
      );
}
