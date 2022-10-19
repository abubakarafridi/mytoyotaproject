import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_toyota/screens/DealearShip.dart';
import 'package:flutter_toyota/screens/Remarks.dart';
import 'package:flutter_toyota/screens/advisor.dart';
import 'package:flutter_toyota/screens/list.dart';
import 'package:flutter_toyota/routes.dart';


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