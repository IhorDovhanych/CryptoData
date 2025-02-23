import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/core/error/base_exception.dart';
import 'package:dartz/dartz.dart';

abstract class CryptocurrencyRepository {
  Future<Either<BaseException, List<CryptocurrencyEntity>>>
      getPagginatedCryptocurrencyList(
          [final int page = 1,
          final int amountPerPage = 10,
          final String vsCurrency = 'usd']);
}
