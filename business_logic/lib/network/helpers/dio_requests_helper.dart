import 'package:flutter_utilities/utilities.dart';

class DioRequestHelper extends DioHttpHelper {
  @override
  Future<Map<String, String>> get headers async => {
        'x-rapidapi-host':
            'vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com',
        'x-rapidapi-key': '9c5b60476cmshf6fd22f24ec50b5p193af1jsn006506e90560'
      };

  @override
  List<Interceptor>? get interceptiors => null;
}
