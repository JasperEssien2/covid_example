// ignore_for_file: overridden_fields

import 'package:business_logic/business_logic_export.dart';
import 'package:flutter_utilities/utilities.dart';

class CountryStatsCubit extends BaseListCubit<CountryStats> {
  final CountriesStatsService service;

  CountryStatsCubit(
      {required this.service, required CountryStatsViewModel viewModel})
      : super(viewModel);

  void fetchStatsByCountry(String countryName, String iso) {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<CountryStats>>(
      () => service.getCountryStatsByCountry(countryName, iso),
      (response) => _handleSuccessResponse(response),
      (error) => emitListError(error),
    );
  }

  _handleSuccessResponse(SuccessResponse<List<CountryStats>> response) {
    viewModel.addToList(response.value);
    response.value.isEmpty
        ? emit(BaseListEmptyState())
        : emitListLoaded(response.value);
  }

  void fetchSixMonthsStatsByCountry(String iso) {
    emitListLoading();

    HandleRequestResponse.handleResponse<List<CountryStats>>(
      () => service.getSixMonthsCountryStatsByCountry(iso),
      (response) => _handleSuccessResponse(response),
      (error) => emitListError(error),
    );
  }

  Map<String, Set<int>> getTotalAndDeathStatistics() {
    return _getTotalAndDeathStatistics(viewModel.itemList) ?? {};
  }

  Map<String, Set<int>>? _getTotalAndDeathStatistics(List<CountryStats> stats) {
    if (stats.isEmpty) {
      return null;
    } else {
      final first = stats.first;

      if(first.date == null) return null;
      final date = DateFormat("yyyy-MM-dd").parse(first.date ?? '');
      
      final month = DateFormat.MMM().format(date);

      var next = _getTotalAndDeathStatistics(stats.sublist(1)) ?? {};

      if (next.containsKey(month)) {
        final prevValue = next[month];

        next[month] = {
          (first.totalCases ?? 0) + (prevValue?.elementAt(0) ?? 0),
          (first.deaths ?? 0) + (prevValue?.elementAt(1) ?? 0),
        };
      } else {
        next[month] = {first.totalCases ?? 0, first.deaths ?? 0};
      }
      return next;
    }
  }
}
