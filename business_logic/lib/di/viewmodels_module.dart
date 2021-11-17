import 'package:business_logic/view_model/view_model_export.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerFactory(() => CountryStatsViewModel());
}
