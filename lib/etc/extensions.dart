extension IntDateParsing on int{
  int toIntWeekDays(){
    int tmp = this+1;
    if (tmp == 8){
      tmp = 1;
    }
    return tmp;
  }
}

extension UriFromString on String{
  Uri toUri(String? pathToAppend){
    Uri res;
    if(pathToAppend == null){
      res = Uri.tryParse(this) ?? Uri();
    }else{
      res = Uri.tryParse(this + pathToAppend) ?? Uri();
    }
    return res;
  }
}