// ignore_for_file: overridden_fields

import 'package:business_logic/business_logic_export.dart';
import 'package:flutter_utilities/utilities.dart';

class CountryStatsListCubit extends BaseListCubit<Country> {
  final CountriesStatsService service;
  CountryStatsListCubit({
    required CountryStatsListViewModel viewModel,
    required this.service,
  }) : super(viewModel);

  void fetchByCountryCodeStats(String countryCode) {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<Country>>(
      () => service.getLatestCountryDataByCode(countryCode),
      (response) {
        viewModel.addToList(response.value);
        emitListLoaded(response.value);
      },
      (error) => emitListError(error),
    );
  }

  void fetchByCountryNameStats(String countryName) {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<Country>>(
      () => service.getLatestCountryDataByName(countryName),
      (response) {
        viewModel.addToList(response.value);
        emitListLoaded(response.value);
      },
      (error) => emitListError(error),
    );
  }

  void fetchCountryStats() {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<Country>>(
      () => service.getLatestAllCountries(),
      (response) {
        viewModel.addToList(response.value);
        emitListLoaded(response.value);
      },
      (error) => emitListError(error),
    );
  }
}
