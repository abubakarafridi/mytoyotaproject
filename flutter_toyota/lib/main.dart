import 'package:flutter/material.dart';
import 'package:flutter_toyota/pages/DealearShip.dart';
import 'package:flutter_toyota/pages/Remarks.dart';
import 'package:flutter_toyota/pages/advisor.dart';
import 'package:flutter_toyota/pages/list.dart';

void main() => runApp(MaterialApp(
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

class MyRoutes {
  static String listRoute = "list";
  static String DealearshipRoute = "Dealear";
  static String AdvisorRoute = "Advisor";
  static String RemarksRoute = "Remarksc";
}
