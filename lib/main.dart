import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mt_activity_management/pages/home.dart';
import 'package:mt_activity_management/pages/loading.dart';
import 'package:mt_activity_management/pages/login.dart';
import 'package:mt_activity_management/pages/programs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static String api = "http://192.168.0.115:8000";

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),

      debugShowCheckedModeBanner: false,
      title: 'Activity management',
      initialRoute: "/login",
      routes: {
        "/" : (context) => const Loading(),
        "/login" : (context) => const Login(),
        "/home" : (context) => const Home(),
        "/programs" : (context) => const Programs(),
      },
    );
  }
}