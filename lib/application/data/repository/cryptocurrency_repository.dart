import 'package:crypto_data/application/data/datasources/cryptocurrency_datasource.dart';
import 'package:crypto_data/application/data/models/cryptocurrency_model.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';
import 'package:crypto_data/application/domain/repository/cryptocurrency_repository.dart';
import 'package:crypto_data/core/error/base_exception.dart';
import 'package:crypto_data/core/error/error_codes.dart';
import 'package:crypto_data/core/utils/print_utils.dart';
import 'package:dartz/dartz.dart';

class CryptocurrencyRepositoryImpl implements CryptocurrencyRepository {
  CryptocurrencyRepositoryImpl(this._cryptocurrencyDatasource);

  final CryptocurrencyDatasource _cryptocurrencyDatasource;

  @override
  Future<Either<BaseException, List<CryptocurrencyEntity>>>
      getPagginatedCryptocurrencyList(
          [final int page = 1,
          final int amountPerPage = 10,
          final String vsCurrency = 'usd']) async {
    try {
      final List<CryptocurrencyModel> models =
          await _cryptocurrencyDatasource.getPagginatedCryptocurrencyList(
        page,
        amountPerPage,
        vsCurrency,
      );

      final List<CryptocurrencyEntity> entities = models.map(
        (final model) => CryptocurrencyEntity(
          id: model.id,
          symbol: model.symbol,
          name: model.name,
          image: model.image,
          currentPrice: model.currentPrice
        ),
      ).toList();

      return Right(entities);
    } catch (e, st) {
      const message = 'Failed to getPagginatedCryptocurrencyList';
      printError(message, e, st);
      return Left(
          BaseException(error: e, stack: st, code: ecNonDio, message: message));
    }
  }
}
