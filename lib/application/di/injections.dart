import 'package:crypto_data/application/data/datasources/cryptocurrency_datasource.dart';
import 'package:crypto_data/application/data/datasources/price_chart_datasource.dart';
import 'package:crypto_data/application/data/repository/cryptocurrency_repository.dart';
import 'package:crypto_data/application/data/repository/price_chart_repository.dart';
import 'package:crypto_data/application/domain/repository/cryptocurrency_repository.dart';
import 'package:crypto_data/application/domain/repository/price_chart_repository.dart';
import 'package:crypto_data/application/domain/usecase/get_pagginated_cryptocurrency_list_use_case.dart';
import 'package:crypto_data/application/domain/usecase/get_price_chart_use_case.dart';
import 'package:crypto_data/application/presentation/features/main/cubit/main_cubit.dart';
import 'package:crypto_data/application/presentation/features/main/features/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

const appScope = 'appScope';

void _initAppScope(final GetIt getIt) {
  //region Services

  //endregion

  //region Data sources
  getIt.registerLazySingleton<CryptocurrencyDatasource>(
      () => CryptocurrencyDatasourceImpl());
  getIt.registerLazySingleton<PriceChartDatasource>(
      () => PriceChartDatasourceImpl());
  //endregion

  //region Repositories
  getIt.registerLazySingleton<CryptocurrencyRepository>(
      () => CryptocurrencyRepositoryImpl(getIt<CryptocurrencyDatasource>()));
  getIt.registerLazySingleton<PriceChartRepository>(
      () => PriceChartRepositoryImpl(getIt<PriceChartDatasource>()));
  //endregion

  //region Use cases
  getIt.registerLazySingleton<GetPagginatedCryptocurrencyListUseCase>(
      () => GetPagginatedCryptocurrencyListUseCase(getIt<CryptocurrencyRepository>()));
  getIt.registerLazySingleton<GetPriceChartUseCase>(
      () => GetPriceChartUseCase(getIt<PriceChartRepository>()));
  //endregion

  //region Cubits
  getIt.registerFactory<MainCubit>(() => MainCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  //endregion
}

final Map<String, ScopeBuilder> _registeredScopes = {
  appScope: _initAppScope,
};

void pushScope(final String scope) {
  if (getIt.currentScopeName == scope) return;
  if (!_registeredScopes.containsKey(scope)) return;
  getIt.pushNewScope(scopeName: scope, init: _registeredScopes[scope]);
}

Future<void> pushScopeAsync(final String scope) async {
  if (getIt.currentScopeName == scope) return;
  if (!_registeredScopes.containsKey(scope)) return;
  getIt.pushNewScope(scopeName: scope, init: _registeredScopes[scope]);
  return getIt.allReady();
}

Future<bool> popScope([final String? scope]) async {
  if (getIt.currentScopeName == appScope) return false;
  if (scope != null) return getIt.popScopesTill(scope);
  await getIt.popScope();
  return true;
}

typedef ScopeBuilder = void Function(GetIt getIt);
