import 'dart:convert';
import 'package:MomNom/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class LoginRequest implements BaseRequest{
  
    String? Password;
    String? Email;

    factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
    Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
    LoginRequest({this.Password, this.Email});
}

@JsonSerializable()
class LoginResponse{
    String? sessionId;
    LoginResponse(this.sessionId);

    factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
    Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}
