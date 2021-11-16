import 'package:business_logic/business_logic_export.dart';
import 'package:business_logic/network/base/endpoints.dart';
import 'package:business_logic/network/helpers/dio_api_consumer.dart';
import 'package:flutter_utilities/request_utility/success/success_response.dart';
import 'package:flutter_utilities/utilities.dart';

class CountriesStatsServiceImpl extends CountriesStatsService {
  final DioHttpHelper requestHelper;

  CountriesStatsServiceImpl({required this.requestHelper});
  @override
  Future<SuccessResponse> getLatestAllCountries() {
    return ApiConsumerHelper.instance.simplifyApiRequest(
      () => requestHelper.get(covidEndpoints.dailyReportAllCountries),
      successResponse: (json) => SuccessResponse(
        (json as List).map((e) => CountryStats.fromMap(e)).toList(),
      ),
    );
  }

  @override
  Future<SuccessResponse> getLatestCountryDataByCode(String code) {
    return ApiConsumerHelper.instance.simplifyApiRequest(
      () => requestHelper.get(covidEndpoints.dailyReportAllCountries,
          queryParameters: {'it': code}),
      successResponse: (json) => SuccessResponse(
        (json as List).map((e) => CountryStats.fromMap(e)).toList(),
      ),
    );
  }

  @override
  Future<SuccessResponse> getLatestCountryDataByName(String name) {
    return ApiConsumerHelper.instance.simplifyApiRequest(
      () => requestHelper.get(covidEndpoints.dailyReportByCountryName,
          queryParameters: {'name': name}),
      successResponse: (json) => SuccessResponse(
        (json as List).map((e) => CountryStats.fromMap(e)).toList(),
      ),
    );
  }
}
