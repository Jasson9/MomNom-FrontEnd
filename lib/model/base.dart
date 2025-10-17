import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';
part 'base.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T>{
  int statusCode;
  String  statusMessage;
  late T? data;
  factory BaseResponse.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,) => _$BaseResponseFromJson(json,fromJsonT);

  Map<String, dynamic> toJson(
      Object Function(T value) toJsonT, // toJsonT for the generic type
      ) =>
      _$BaseResponseToJson(this, toJsonT);

  BaseResponse({required this.statusCode, required this.statusMessage, this.data});
}
