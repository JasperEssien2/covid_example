import 'package:business_logic/business_logic_export.dart';
import 'package:business_logic/di/cubit_module.dart' as cubit;
import 'package:business_logic/di/services_module.dart' as service;
import 'package:business_logic/di/viewmodels_module.dart' as viewmodel;

final GetIt injector = GetIt.instance;

Future<void> init() async {
  cubit.init(injector);
  viewmodel.init(injector);
  service.init(injector);
}
