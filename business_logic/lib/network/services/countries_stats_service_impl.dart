import 'package:business_logic/business_logic_export.dart';
import 'package:business_logic/network/base/endpoints.dart';
import 'package:business_logic/network/helpers/dio_api_consumer.dart';
import 'package:flutter_utilities/request_utility/success/success_response.dart';
import 'package:flutter_utilities/utilities.dart';

class CountriesStatsServiceImpl extends CountriesStatsService {
  final DioHttpHelper requestHelper;

  CountriesStatsServiceImpl({required this.requestHelper});

  @override
  Future<SuccessResponse> getCountryStatsByCountry(String name, String iso) {
    return ApiConsumerHelper.instance.simplifyApiRequest(
      () => requestHelper.get(covidEndpoints.reportByCountry(name, iso)),
      successResponse: (json) => SuccessResponse(
        (json as List).map((e) => CountryStats.fromJson(e)).toList(),
      ),
    );
  }

  @override
  Future<SuccessResponse> getSixMonthsCountryStatsByCountry(String iso) {
    return ApiConsumerHelper.instance.simplifyApiRequest(
      () => requestHelper.get(covidEndpoints.sixMonthStatsForCountry(iso)),
      successResponse: (json) => SuccessResponse(
        (json as List).map((e) => CountryStats.fromJsonStats(e)).toList(),
      ),
    );
  }
}
