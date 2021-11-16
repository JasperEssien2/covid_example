import 'package:business_logic/business_logic_export.dart';
import 'package:business_logic/network/network_export.dart';
import 'package:flutter_utilities/request_utility/success/success_response.dart';

class FakeCountryStatsServices extends CountriesStatsService {
  bool returnSucces = true;

  CountryStats? dataToReturn;

  @override
  Future<SuccessResponse> getLatestAllCountries() {
    throw UnimplementedError();
  }

  @override
  Future<SuccessResponse> getLatestCountryDataByCode(String code) async {
    return _dummyResponse();
  }

  @override
  Future<SuccessResponse> getLatestCountryDataByName(String name) async {
    return _dummyResponse();
  }

  SuccessResponse<dynamic> _dummyResponse() {
    if (returnSucces) {
      return SuccessResponse(dataToReturn ?? const CountryStats.dummy());
    } else {
      throw RequestFailedException(
          ErrorResponse(errorMessage: 'An error occurred'));
    }
  }
}
