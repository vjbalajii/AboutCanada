import 'package:about_canada/model/repository/country_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../model/apis/api_response.dart';
import '../model/country.dart';
import '../resource/app_constants.dart';

abstract class CountryViewModel with ChangeNotifier{

  CountryViewModel({
    required this.repo,
  });

  final CountryRepository repo;

  ApiResponse _countryResponse = ApiResponse.initial(AppConstants.emptyData);

  ApiResponse get countryResponse;

  Country get countryModel;

  Future<Country?> fetchCountryData();
}

class CountryViewModelImpl extends CountryViewModel{

  Country? _country;

  CountryViewModelImpl({required CountryRepository repo})
      : super(repo: repo);

  @override
  ApiResponse get countryResponse {
    return _countryResponse;
  }

  @override
  Country get countryModel {
    return _country!;
  }

  ///Fetches country data api and return Country model
  @override
  Future<Country?> fetchCountryData() async {
    _countryResponse = ApiResponse.loading(AppConstants.fetchingData);
    Country model = Country();
    notifyListeners();
    try {
      model = await repo.fetchCountryData();
      _countryResponse = ApiResponse.completed(model);
    } catch (e) {
      _countryResponse = ApiResponse.error(e.toString());
      print(e);
      rethrow;
    }
    notifyListeners();
    return model;
  }

}