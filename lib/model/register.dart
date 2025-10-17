import 'dart:convert';
import 'package:MomNom/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register.g.dart';

@JsonSerializable()
class RegisterRequest{
  
    String? Password;
    String? Email;
    String? Username;
    String? PasswordConfirm;

    factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
    Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
    RegisterRequest({this.Password, this.Email, this.PasswordConfirm, this.Username});
}

@JsonSerializable()
class RegisterResponse{
    String? sessionId;
    RegisterResponse(this.sessionId);

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
    Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
