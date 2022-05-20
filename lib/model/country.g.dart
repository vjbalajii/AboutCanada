// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      title: json['title'],
    )..rows = (json['rows'] as List<dynamic>)
        .map((e) => Details.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'title': instance.title,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };
