import 'dart:convert';

import '../country.dart';
import '../services/base_service.dart';
import '../services/country_service.dart';

abstract class CountryRepository {
  Future<Country> fetchCountryData();
}

class CountryRepositoryImpl extends CountryRepository{
  final BaseService _countryService = CountryService();

  ///Fetches country data api and return country model
  @override
  Future<Country> fetchCountryData() async {
    dynamic response = await _countryService.getCountryResponse();
    Country model = Country.fromJson(response);

    return model;
  }

}