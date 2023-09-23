import 'dart:convert';
import 'dart:io';

import 'package:doctor_consultation_app/models/services/base_service.dart';
import 'package:http/http.dart' as http;

import '../app_exception.dart';

class DoctorService extends BaseService{
  @override
  Future getResponse(String url) async{
    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse("$baseUrl/$url"));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet.");
    }
    return jsonResponse;
  }

  returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);

      case 400:
        throw BadRequestException(message: response.body);

      case 401:
      case 403:
        throw UnAuthorizedException(message: response.body);

      case 500:
      default:
        throw FetchDataException(
            message:
                "Error occured while communication with server with status code ${response.statusCode}");
    }
  }

}