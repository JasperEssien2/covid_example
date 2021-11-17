import 'package:business_logic/business_logic_export.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton<DioHttpHelper>(() => DioRequestHelper());

  injector.registerLazySingleton<CountriesStatsService>(
      () => CountriesStatsServiceImpl(requestHelper: injector.get()));
}
