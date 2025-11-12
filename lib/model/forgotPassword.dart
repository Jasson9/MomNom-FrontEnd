import 'dart:convert';
import 'package:MomNom/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'forgotPassword.g.dart';

@JsonSerializable()
class ForgotPasswordRequest implements BaseRequest{

    String? password;
    String? email;
    String? confirmPassword;

    factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => _$ForgotPasswordRequestFromJson(json);
    Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
    ForgotPasswordRequest({this.password, this.email, this.confirmPassword});
}

@JsonSerializable()
class ForgotPasswordResponse{
    String? message;
    ForgotPasswordResponse(this.message);

    factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgotPasswordResponseFromJson(json);
    Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
