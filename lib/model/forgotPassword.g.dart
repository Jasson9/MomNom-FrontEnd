// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgotPassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequest(
  password: json['password'] as String?,
  email: json['email'] as String?,
  confirmPassword: json['confirmPassword'] as String?,
);

Map<String, dynamic> _$ForgotPasswordRequestToJson(
  ForgotPasswordRequest instance,
) => <String, dynamic>{
  'password': instance.password,
  'email': instance.email,
  'confirmPassword': instance.confirmPassword,
};

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResponse(json['message'] as String?);

Map<String, dynamic> _$ForgotPasswordResponseToJson(
  ForgotPasswordResponse instance,
) => <String, dynamic>{'message': instance.message};
