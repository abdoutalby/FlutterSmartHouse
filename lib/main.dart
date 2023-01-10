import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarthouse/utils/binding.dart';
import 'package:smarthouse/views/Login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline6: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
              bodyText2: TextStyle(
                  fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
              bodyText1: TextStyle(
                  fontSize: 14.0, fontFamily: 'Hind', color: Colors.white)),
        ),
        home:  LoginPage());
  }
}

