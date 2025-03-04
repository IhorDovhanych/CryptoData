import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:crypto_data/application/domain/repository/cryptocurrency_repository.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/usecase/get_pagginated_cryptocurrency_list_use_case.dart';
import 'package:crypto_data/core/error/base_exception.dart';
import 'get_pagginated_cryptocurrency_list_use_case_test.mocks.dart';

const cryptocurrency_list = [
  CryptocurrencyEntity(
    id: '1',
    symbol: 'BTC',
    name: 'Bitcoin',
    image: 'https://bitcoin.com/bitcoin.png',
    currentPrice: 50000.0,
  ),
  CryptocurrencyEntity(
    id: '2',
    symbol: 'ETH',
    name: 'Ethereum',
    image: 'https://ethereum.org/ethereum.png',
    currentPrice: 4000.0,
  ),
];

@GenerateMocks([CryptocurrencyRepository])
Future<void> main() async {
  late GetPagginatedCryptocurrencyListUseCase getPagginatedCryptocurrencyListUseCase;
  late MockCryptocurrencyRepository mockCryptocurrencyRepository;

  setUp(() {
    mockCryptocurrencyRepository = MockCryptocurrencyRepository();
    getPagginatedCryptocurrencyListUseCase =
        GetPagginatedCryptocurrencyListUseCase(mockCryptocurrencyRepository);
  });

  group('GetPagginatedCryptocurrencyListUseCase', () {
    test('should call GetPagginatedCryptocurrencyListUseCase', () async {
      when(mockCryptocurrencyRepository.getPagginatedCryptocurrencyList(
              1, 1, 'usd'))
          .thenAnswer((_) async => Right(cryptocurrency_list));

      // Act
      var result = await getPagginatedCryptocurrencyListUseCase(const Tuple3(1, 1, 'usd'));

      // Assert
      expect(result, isA<Either<BaseException, List<CryptocurrencyEntity>>>());
    });
  });
}
