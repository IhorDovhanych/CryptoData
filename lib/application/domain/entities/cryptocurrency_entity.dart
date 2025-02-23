import 'package:equatable/equatable.dart';

class CryptocurrencyEntity extends Equatable {
  const CryptocurrencyEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
  });

  factory CryptocurrencyEntity.fromJson(final Map<String, dynamic> json) => CryptocurrencyEntity(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      currentPrice: json['current_price'],
    );

  Map<String, dynamic> toJson() => {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
    };

  CryptocurrencyEntity copyWith({
    final String? id,
    final String? symbol,
    final String? name,
    final String? image,
    final dynamic? currentPrice,
  }) => CryptocurrencyEntity(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
    );

  @override
  List<Object?> get props => [id, symbol, name, image, currentPrice];

  final String id;
  final String symbol;
  final String name;
  final String image;
  final dynamic currentPrice;
}