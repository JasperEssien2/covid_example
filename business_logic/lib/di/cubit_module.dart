import 'package:business_logic/cubit/country_stats/country_stats_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerFactory<CountryStatsCubit>(() =>
      CountryStatsCubit(service: injector.get(), viewModel: injector.get()));
}
