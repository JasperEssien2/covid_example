import 'package:dio/src/response.dart';
import 'package:flutter_utilities/utilities.dart';

class ApiConsumerHelper extends DioApiConsumption {
  static ApiConsumerHelper? _instance;

  // ignore: unused_element
  ApiConsumerHelper._();

  static ApiConsumerHelper get instance {
    _instance ??= ApiConsumerHelper.factory();
    return _instance!;
  }

  ApiConsumerHelper.factory();

  @override
  ErrorResponse parseErrorFromResponse(Response requestResponse) {
    return ErrorResponse(errorMessage: "An error occurred, please try again");
  }
}
