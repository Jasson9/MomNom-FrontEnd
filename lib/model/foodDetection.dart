
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
import 'model.dart';
part 'foodDetection.g.dart';

@JsonSerializable()
class FoodDetectionRequest implements BaseRequest{
    String imageBase64;

    FoodDetectionRequest(this.imageBase64);

    factory FoodDetectionRequest.fromJson(Map<String, dynamic> json) => _$FoodDetectionRequestFromJson(json);
    Map<String, dynamic> toJson() => _$FoodDetectionRequestToJson(this);
}

@JsonSerializable()
class FoodDetectionResponse{

    List<String>? foodNameList;

    FoodDetectionResponse({this.foodNameList});
    factory FoodDetectionResponse.fromJson(Map<String, dynamic> json) => _$FoodDetectionResponseFromJson(json);
    Map<String, dynamic> toJson() => _$FoodDetectionResponseToJson(this);
}