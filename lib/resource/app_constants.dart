import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  //URLS
  static const String countryURL = 'https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf';

  static const String emptyImage = 'assets/images/ic_empty.png';

  //RESPONSE_CODES
  static const responseSuccess = 200;
  static const responseBadRequest = 400;
  static const responseInvalidAuthentication = 401;
  static const responseUnauthorised = 403;
  static const responseInternalServerError = 500;
  static const responseServiceUnavailable = 503;

  //EXCEPTIONS
  static const String fetchError = 'Error During Fetch: ';
  static const String invalidRequest = 'Invalid Request: ';
  static const String unauthorisedRequest = 'Unauthorised Request: ';
  static const String invalidAuthentication = 'Invalid Authentication Error: ';
  static const String internalServerError = 'Internal Server Error: ';
  static const String serviceUnavailableError = 'Service Unavailable Error: ';
  static const String invalidInputError = 'Invalid Input: ';
  static const String noInternetError = 'No Internet Connection';
  static const String communicationError = 'Error occurred while communication with server' ' with status code :';

  //VIEW KEYS
  static const String searchViewKey = 'searchViewKey';
  static const String floatingButtonKey = 'floatingButtonKey';
  static const String loadingWidgetKey = 'loadingWidgetKey';
  static const String normalListViewKey = 'normalListViewKey';
  static const String searchListViewKey = 'searchListViewKey';
  static const String errorViewKey = 'errorViewKey';

  //INFO TEXTS
  static const String enterTitle = 'Enter title to search';
  static const String loadingTitle = 'Loading data..';
  static const String errorLoadingData = 'Error loading data!';
  static const String emptyData = 'Empty data';
  static const String fetchingData = 'Fetching data';
  static const String toastInvalidTitle = 'Invalid title value';

  //TEXT FORMAT
  static const onlyAlphabets = r'[a-z]';
  
  //SPACES & MARGINS
  static const containerBig = 300.0;
  static const containerSmall = 150.0;
  static const imageHeight = 180.0;
  static const imageWidth = 140.0;
  static const tabBarHeight = 60.0;
  static const toastSize = 16.0;
  static const spaceBig = 20.0;
  static const spaceMedium = 16.0;
  static const spaceSmall = 8.0;
  static const radiusBig = 25.0;
  static const dimensionBig = 16.0;
  static const dimensionMedium = 8.0;
  static const dimensionSmall = 4.0;
  static const dimensionZero = 0.0;
  static const divider = 2.0;
  static const alphaSmall = 10;
  static const alphaMedium = 50;
  static const alphaHigh = 100;
}