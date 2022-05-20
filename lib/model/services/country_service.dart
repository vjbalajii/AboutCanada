import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../resource/app_constants.dart';
import '../apis/app_exception.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class CountryService extends BaseService{

  ///Calls countryResponse api and return country details json data
  @override
  Future getCountryResponse() async {

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(countryURL));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetError);
    } on Exception{
      throw Exception(AppConstants.errorLoadingData);
    }
    return responseJson;
  }

  ///Returns response for apis
  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case AppConstants.responseSuccess:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case AppConstants.responseBadRequest:
        throw BadRequestException(response.body.toString());
      case AppConstants.responseInvalidAuthentication:
        throw InvalidAuthenticationException(response.body.toString());
      case AppConstants.responseUnauthorised:
        throw UnauthorisedException(response.body.toString());
      case AppConstants.responseInternalServerError:
        throw InternalServerException(response.body.toString());
      case AppConstants.responseServiceUnavailable:
        throw ServiceUnavailableException(response.body.toString());
      default:
        throw FetchDataException(
            AppConstants.communicationError+' ${response.statusCode}');
    }
  }

}