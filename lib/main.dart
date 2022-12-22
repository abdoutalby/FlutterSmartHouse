import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarthouse/views/camera.dart';
import 'package:smarthouse/views/cuisine.dart';
import 'package:smarthouse/views/salon.dart';
import 'package:smarthouse/views/temp_exterieure.dart';
import 'package:smarthouse/views/temp_sonde.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
        home: const MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final titlees = [
    "temperature exterieure",
    "salon",
    "Cuisine",
    "Camera",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: titlees[0]),
            Tab(
              text: titlees[1],
            ),
            Tab(
              text: titlees[2],
            ),
            Tab(
              text: titlees[3],
            ),

          ],
        ),
        title: Text(titlees[controller.index]),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          TemperatureExterieure(),
          Salon(),
          Cuisine(),
          Camera()
        ],
      ),
    );
  }
}
