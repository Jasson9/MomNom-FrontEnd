import 'package:MomNom/pages/dashboard.dart';
import 'package:MomNom/pages/diaryPage.dart';
import 'package:MomNom/pages/exercisePage.dart';
import 'package:MomNom/pages/planPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../etc/styles.dart';
import 'package:intl/intl.dart';

mixin CustomNavBar implements NavigationBar {
  static Widget navbar(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: CustomColor.darkGray, blurRadius: 8),
        ],
      ),
      child: Hero(
        tag: 'BottomAppbar',
        child: NavigationBar(
          // shadowColor: CustomColor.black,
          elevation: 200,
          selectedIndex: index,
          onDestinationSelected: (int index) {
            String destPath = "";
            Object arguments = Object();
            Widget page = context.widget;
            switch (index) {
              case 0:
                page = DashboardPage();
                destPath = "/dashboard";
                break;
              case 1:
                page = DiaryPage();
                destPath = "/diary";
                break;
              case 2:
                page = ExercisePage();
                destPath = "/exercise";
                break;
              case 3:
                page = PlanPage();
                destPath = "/plan";
                arguments = PlanArguments(date: DateTime.now());
                break;
            }
            Navigator.pushReplacementNamed(
              context,
              destPath,
              arguments: arguments,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: CustomColor.white, size: 36),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.food_bank, color: CustomColor.white, size: 36),
              label: "Diary",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.sports_gymnastics,
                color: CustomColor.white,
                size: 36,
              ),
              label: "Exercise",
            ),
            NavigationDestination(
              icon: Icon(Icons.notes, color: CustomColor.white, size: 36),
              label: "Plan",
            ),
          ],
          backgroundColor: CustomColor.primaryDark,
          indicatorColor: CustomColor.secondary,
          labelTextStyle: WidgetStateTextStyle.resolveWith((Set state) {
            return CustomText.text1(color: CustomColor.white);
          }),
        ),
      ),
    );
  }
}
