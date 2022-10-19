import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_toyota/pages/DealearShip.dart';
import 'package:flutter_toyota/pages/Remarks.dart';
import 'package:flutter_toyota/pages/advisor.dart';
import 'package:flutter_toyota/pages/list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.black),
    home: const index(),
    initialRoute: MyRoutes.listRoute,
    routes: {
      MyRoutes.listRoute: (context) => index(),
      MyRoutes.DealearshipRoute: (context) => DealearShip(),
      MyRoutes.AdvisorRoute: (context) => Advisor(),
      MyRoutes.RemarksRoute: (context) => Remarks(),
    },
  ));
  configLoading();
}

class MyRoutes {
  static String listRoute = "list";
  static String DealearshipRoute = "Dealear";
  static String AdvisorRoute = "Advisor";
  static String RemarksRoute = "Remarksc";
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom //This was missing in earlier code
    ..backgroundColor = Colors.blue
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    //..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    //..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    //..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}


//Classes PascalCase
//Objects and Variables and functionNames camelCase
//clase file name snake_case