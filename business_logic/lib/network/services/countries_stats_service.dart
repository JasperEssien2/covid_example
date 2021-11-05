import 'package:flutter_utilities/utilities.dart';

abstract class CountriesStatsService {
  Future<SuccessResponse> getLatestAllCountries();

  Future<SuccessResponse> getLatestCountryDataByName(String name);

  Future<SuccessResponse> getLatestCountryDataByCode(String code);
}
