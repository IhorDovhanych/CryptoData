import 'package:crypto_data/application/data/models/cryptocurrency_model.dart';
import 'package:crypto_data/application/domain/entities/cryptocurrency_entity.dart';

extension CryptocurrencyEntityX on CryptocurrencyEntity {
  CryptocurrencyModel get toModel => CryptocurrencyModel(
        id: id,
        symbol: symbol,
        name: name,
        image: image,
        currentPrice: currentPrice,
      );
}

extension CryptocurrencyX on CryptocurrencyModel {
  CryptocurrencyEntity get toEntity => CryptocurrencyEntity(
        id: id,
        symbol: symbol,
        name: name,
        image: image,
        currentPrice: currentPrice
      );
}