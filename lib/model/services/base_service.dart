import '../../resource/app_constants.dart';

abstract class BaseService{

  final String countryURL = AppConstants.countryURL;

  Future<dynamic> getCountryResponse();

}