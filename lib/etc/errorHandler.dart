import 'package:flutter/cupertino.dart';

import '../components/snackbar.dart';
import '../model/exceptions.dart';

void customErrorHandler(ex, context){
  if(ex is APIException){
    if(ex.code == 400){
      CustomSnackbar.showErrorSnackbar(ex.message, context);
    }else
    if(ex.code == 401){
      CustomSnackbar.showErrorSnackbar(UnAuthorizedException().message, context);
      Navigator.pushReplacementNamed(context, "/login");
    }else
    CustomSnackbar.showErrorSnackbar("API Exception: ${ex.code}, ${ex.message}", context);
  }else if(ex is HttpException){
    CustomSnackbar.showErrorSnackbar("Http Exception: ${ex.code}, ${ex.message}", context);
  }else if(ex is ValidationException){
    CustomSnackbar.showErrorSnackbar(ex.message, context);
  }else if(ex is CustomException){
    CustomSnackbar.showErrorSnackbar("Unknown Exception ${ex.message}", context);
  }else{
    CustomSnackbar.showErrorSnackbar("Internal Error $ex", context);
  }
}