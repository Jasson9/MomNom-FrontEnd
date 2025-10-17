// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  Password: json['Password'] as String?,
  Email: json['Email'] as String?,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{'Password': instance.Password, 'Email': instance.Email};

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(json['sessionId'] as String?);

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{'sessionId': instance.sessionId};
