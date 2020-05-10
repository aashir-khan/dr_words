import 'package:dr_words/core/data/mock_shared_preferences.dart';
import 'package:dr_words/features/query_search/data/datasources/remote/query_search_remote_data_source_fake.dart';
import 'package:dr_words/injection.iconfig.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Env {
  static const test = 'test';
  static const development = 'development';
  static const production = 'production';
}

Future<void> configureInjection(String environment) async {
  await configureManualInjection(environment);
  configureAutomaticInjection(environment);
}

final GetIt getIt = GetIt.instance;

@injectableInit
void configureAutomaticInjection(String environment) => $initGetIt(getIt, environment: environment);

Future<void> configureManualInjection(String environment) async {
  if (environment == Env.production) {
    await _registerProductionDependencies();
  }
  if (environment == Env.development) {
    await _registerDevelopmentDependencies();
  }
  if (environment == Env.test) {
    await _registerTestDependencies();
  }
}

Future _registerProductionDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

Future _registerDevelopmentDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Clear any local storage data
  await sharedPreferences.remove(QuerySearchRemoteDataSourceFake.QUERY_SEARCH_RESULTS_MODEL_DB_IDENTIFIER);
}

Future _registerTestDependencies() async {
  getIt.registerLazySingleton<SharedPreferences>(() => MockSharedPreferences());
}
