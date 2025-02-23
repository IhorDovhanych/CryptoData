import 'package:crypto_data/application/domain/core/use_case.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/repository/cryptocurrency_repository.dart';
import 'package:crypto_data/core/error/base_exception.dart';
import 'package:dartz/dartz.dart';

class GetPagginatedCryptocurrencyListUseCase
    extends AsyncUseCase<Tuple3<int, int, String>, List<CryptocurrencyEntity>> {
  const GetPagginatedCryptocurrencyListUseCase(this._cryptocurrencyRepository);

  final CryptocurrencyRepository _cryptocurrencyRepository;

  @override
  Future<Either<BaseException, List<CryptocurrencyEntity>>> call(
      final Tuple3<int, int, String> params) async {
    final int page = params.value1;
    final int amountPerPage = params.value2;
    final String vsCurrency = params.value3;
    return _cryptocurrencyRepository.getPagginatedCryptocurrencyList(
        page, amountPerPage, vsCurrency);
  }
}
