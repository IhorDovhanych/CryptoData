import 'package:flutter/cupertino.dart';

@immutable
class CryptocurrencyModel {

  const CryptocurrencyModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
  });

  factory CryptocurrencyModel.fromJson(final Map<String, dynamic> json) => CryptocurrencyModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      currentPrice: json['current_price'],
    );

  final String id;
  final String symbol;
  final String name;
  final String image;
  final dynamic currentPrice;

    Map<String, dynamic> toJson() => {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
    };
}
