// ignore_for_file: overridden_fields

import 'package:business_logic/business_logic_export.dart';
import 'package:flutter_utilities/utilities.dart';

class CountryStatsCubit extends BaseObjectCubit<CountryStats> {
  final CountriesStatsService service;

  CountryStatsCubit({
    required this.service,
  }) : super();

  void fetchStatsByCountryCode(String countryCode) {
    emitLoading();

    HandleRequestResponse.handleResponse<CountryStats>(
      () => service.getLatestCountryDataByCode(countryCode),
      (response) => emitLoaded(response.value),
      (error) => emitError(error),
    );
  }

  void fetchStatsByCountryName(String countryName) {
    emitLoading();

    HandleRequestResponse.handleResponse<CountryStats>(
      () => service.getLatestCountryDataByName(countryName),
      (response) => emitLoaded(response.value),
      (error) => emitError(error),
    );
  }
}
