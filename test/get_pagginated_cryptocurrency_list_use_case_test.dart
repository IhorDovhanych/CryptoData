import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:crypto_data/application/data/repository/cryptocurrency_repository.dart';
import 'package:crypto_data/application/domain/models/cryptocurrency_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('UseCases', () {
    late GetPagginatedCryptocurrencyListUseCase useCase;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      useCase = GetPagginatedCryptocurrencyListUseCase(mockHttpClient);
    });

    test('getPagginatedCryptocurrencyList should run without errors', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response('[]', 200));

      // Act
      final result = await repository.getPagginatedCryptocurrencyList();

      // Assert
      expect(result, isA<List<CryptocurrencyModel>>());
    });
  });
}
