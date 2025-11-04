
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
import 'model.dart';
part 'addDiary.g.dart';

@JsonSerializable()
class AddDiaryFoodItem{
    String? foodName;
    double? amountGr;

    AddDiaryFoodItem({required this.foodName, required this.amountGr});

    factory AddDiaryFoodItem.fromJson(Map<String, dynamic> json) => _$AddDiaryFoodItemFromJson(json);
    Map<String, dynamic> toJson() => _$AddDiaryFoodItemToJson(this);
}

@JsonSerializable()
class AddDiaryRequest implements BaseRequest{
    DateTime date;
    List<AddDiaryFoodItem> foodItems;
    AddDiaryRequest(this.date,this.foodItems);

    factory AddDiaryRequest.fromJson(Map<String, dynamic> json) => _$AddDiaryRequestFromJson(json);
    Map<String, dynamic> toJson() => _$AddDiaryRequestToJson(this);
}

@JsonSerializable()
class AddDiaryResponse{

    List<int>? foodIds;

    AddDiaryResponse({this.foodIds});
    factory AddDiaryResponse.fromJson(Map<String, dynamic> json) => _$AddDiaryResponseFromJson(json);
    Map<String, dynamic> toJson() => _$AddDiaryResponseToJson(this);
}