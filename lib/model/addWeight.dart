
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
import 'model.dart';
part 'addWeight.g.dart';


@JsonSerializable()
class AddWeightRequest implements BaseRequest{
    int month;
    int year;
    double weight;
    AddWeightRequest({required this.month, required this.year, required this.weight});

    factory AddWeightRequest.fromJson(Map<String, dynamic> json) => _$AddWeightRequestFromJson(json);
    Map<String, dynamic> toJson() => _$AddWeightRequestToJson(this);
}