import 'package:flutter_utilities/utilities.dart';

abstract class CountriesStatsService {
  Future<SuccessResponse> getCountryStatsByCountry(String name, String iso);
  
  Future<SuccessResponse> getSixMonthsCountryStatsByCountry(String iso);
}
