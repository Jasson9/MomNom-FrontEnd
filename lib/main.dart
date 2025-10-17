import 'package:MomNom/pages/adddiaryPage.dart';
import 'package:MomNom/components/button.dart';
import 'package:MomNom/pages/profilePage.dart';
import 'package:MomNom/etc/transitions.dart';
import 'package:MomNom/etc/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'etc/styles.dart';
import 'components/textfield.dart';
import 'pages/loginPage.dart';
import 'pages/registerPage.dart';
import 'pages/createPlanPage.dart';
import 'pages/dashboard.dart';
import 'pages/diaryPage.dart';
import 'pages/exercisePage.dart';
import 'pages/planPage.dart';
import 'pages/dailydiaryPage.dart';
import 'pages/adddiaryPage.dart';

void main() async {
  await initializeDateFormatting('en_US', null);
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static List<PageRouteProperty> pages = [
    const LoginPage()
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MomNom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColor.primary),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: FadePageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            // Example: iOS slide transition
            // Add other platforms as needed
          },
        ),
      ),
      initialRoute: '/',
      // routes: {
      //   for(var page in pages) page.routeName: (context) => page
      // },

      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/createPlan': (context) => const CreatePlanPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/diary': (context) => const DiaryPage(),
        '/exercise': (context) => const ExercisePage(),
        '/plan': (context) => const PlanPage(),
        DailyDiaryPage.routeName: (context) => const DailyDiaryPage(),
        AddDiaryPage.routeName: (context) => const AddDiaryPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
      },
    );
  }
}

class UnanimatedPageRoute<T> extends MaterialPageRoute<T> {
  UnanimatedPageRoute({
    required Widget Function(BuildContext) builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
         builder: builder,
         settings: settings,
         maintainState: maintainState,
         fullscreenDialog: fullscreenDialog,
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
