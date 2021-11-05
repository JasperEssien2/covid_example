import 'package:dio/src/interceptor.dart';
import 'package:flutter_utilities/utilities.dart';

class DioRequestHelper extends DioHttpHelper {
  @override
  Future<Map<String, String>> get headers async => {
        'x-rapidapi-host': 'covid-19-data.p.rapidapi.com',
        'x-rapidapi-key': 'SIGN-UP-FOR-KEY'
      };

  @override
  List<Interceptor>? get interceptiors => null;
}
