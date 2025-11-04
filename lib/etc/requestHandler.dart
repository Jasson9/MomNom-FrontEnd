import 'dart:convert';

import 'package:MomNom/etc/urlEndpoint.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/base.dart';
import '../model/exceptions.dart';
import 'extensions.dart';
class RequestHandler {
   static Future<dynamic> sendRequest<T>({BaseRequest? item,required Uri url,
       bool useAuth = true}) async  {
     // if(T is JsonParseable == false)throw Exception("Invalid Type");
    final prefs = await SharedPreferences.getInstance();
    final authToken = useAuth? prefs.getString("authToken") : "";
    print(jsonEncode(item?.toJson()));
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authentication' : authToken ?? ''
      },
      body: item != null ?jsonEncode(item.toJson()) : jsonEncode({}),
    ).timeout(const Duration(seconds: 60));
    if (response.statusCode != 200) {
      throw HttpException(response.statusCode, response.body);
    }
    var respJson = jsonDecode(response.body);
    print(respJson);
    if (respJson['statusCode'] != 200) {
      throw APIException(
        respJson['statusCode'] ?? 500,
        respJson['statusMessage'] ?? "Null Status Message",
      );
    }
    return respJson;
  }

}