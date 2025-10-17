import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';

class CustomException implements Exception{
  String message;

  CustomException(this.message);
}

class APIException extends CustomException{
  int code;
  APIException(this.code, super.message);
}

class HttpException extends CustomException{
  int code;
  HttpException(this.code, super.message);
}

class ValidationException extends CustomException{
  ValidationException(super.message);
}

class UnAuthorizedException extends CustomException{
  UnAuthorizedException() : super("User unauthorized, session expired or invalid credentials. Returning to Login.");
}
