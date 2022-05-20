import 'details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country{

  dynamic title;
  List<Details> rows;

  Country(
      {this.title,
        List<Details>? details,
      }): rows = details ?? <Details>[];

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

}