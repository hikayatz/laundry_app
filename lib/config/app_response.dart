import 'dart:convert';

import 'package:http/http.dart';
import 'package:laundry_app/config/failure.dart';

class AppResponse {
  static Map data(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseBody = jsonDecode(response.body);
        return responseBody;
      case 204:
        return {'success': true};
      case 400:
        throw BadRequestFailure(response.body);
      case 401:
        throw AnauthorizedFailure(response.body);
      case 422:
        throw InvalidInputFailure(response.body);
      case 403:
        throw ForbiddenFailure(response.body);
      case 404:
        throw NotFoundFailure(response.body);
      case 500:
        throw ServerFailure(response.body);
      default:
        throw FetchFailure(response.body);
    }
  }
}
