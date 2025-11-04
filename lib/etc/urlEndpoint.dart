import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'extensions.dart';
class URLEndpoint {
  // change to serverUrl or private network url:port (cannot use 127.0.0.1 nor localhost nor 0.0.0.0)
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? "";

  static Uri get loginEndpoint => baseUrl.toUri("/Login");
  static Uri get registerEndpoint => baseUrl.toUri("/Register");
  static Uri get createPlanEndpoint => baseUrl.toUri("/CreatePlan");
  static Uri get seePlanEndpoint => baseUrl.toUri("/seePlan");
  static Uri get dashboardEndpoint => baseUrl.toUri("/Dashboard");
  static Uri get weeklyLogReport => baseUrl.toUri("/WeeklyLogReport");
  static Uri get dailyCalorieLog => baseUrl.toUri("/DailyCalorieLog");
  static Uri get addFoodDiary => baseUrl.toUri("/AddFoodDiary");
  static Uri get foodDetection => baseUrl.toUri("/FoodDetection");
}
