import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_utilities/utilities.dart';

class DioRequestHelper extends DioHttpHelper {
  @override
  Future<Map<String, String>> get headers async{

    return {
      
        'x-rapidapi-host':
            'vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com',
        'x-rapidapi-key': dotenv.env['RAPID_KEY'] ?? '',
      };
  }

  @override
  List<Interceptor>? get interceptiors => null;
}
