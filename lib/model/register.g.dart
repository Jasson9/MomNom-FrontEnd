// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      Password: json['Password'] as String?,
      Email: json['Email'] as String?,
      PasswordConfirm: json['PasswordConfirm'] as String?,
      Username: json['Username'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'Password': instance.Password,
      'Email': instance.Email,
      'Username': instance.Username,
      'PasswordConfirm': instance.PasswordConfirm,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(json['sessionId'] as String?);

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{'sessionId': instance.sessionId};
