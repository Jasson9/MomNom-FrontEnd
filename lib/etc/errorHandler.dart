import 'package:flutter/cupertino.dart';

import '../components/button.dart';
import '../components/snackbar.dart';
import '../model/exceptions.dart';

Widget errorWidget(snapshot, VoidCallback onRetry){
  var ex = snapshot.error as CustomException;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${ex.message}'),
        CustomButton.secondary(
          text: "Retry",
          onPress:onRetry
        ),
      ],
    ),
  );
}

dynamic customErrorHandler(ex, context){
  String finalMessage = "";
  if(ex is APIException){
    if(ex.code == 400){
      finalMessage = ex.message;
    }else
    if(ex.code == 401){
      finalMessage = UnAuthorizedException().message;
      Navigator.pushReplacementNamed(context, "/login");
    }else
    finalMessage = "API Exception: ${ex.code}, ${ex.message}";
  }else if(ex is HttpException){
    finalMessage = "Http Exception: ${ex.code}, ${ex.message}";
  }else if(ex is ValidationException){
    finalMessage = ex.message;
  }else if(ex is EmptyAuthException){
    return CustomException("Empty AuthToken");
  }else if(ex is CustomException){
    finalMessage = "Unknown Exception ${ex.message}";
  }else{
    finalMessage = "Internal Error $ex";
  }
  CustomSnackbar.showErrorSnackbar(finalMessage, context);
  return CustomException(finalMessage);
}