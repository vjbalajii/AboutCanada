import 'package:json_annotation/json_annotation.dart';
part 'details.g.dart';

@JsonSerializable()
class Details{

  dynamic title;
  dynamic description;
  dynamic imageHref;

  Details({
    this.title,
    this.description,
    this.imageHref,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);


}