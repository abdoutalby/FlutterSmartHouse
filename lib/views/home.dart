import 'package:flutter/material.dart';
import 'package:smarthouse/views/salon.dart';

import 'camera.dart';
import 'cuisine.dart';

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
    controller = TabController(length: 3, vsync: this);
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
             Tab(
              text: titlees[0],
            ),
            Tab(
              text: titlees[1],
            ),
            Tab(
              text: titlees[2],
            ),

          ],
        ),
        title: Text(titlees[controller.index]),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          Salon(),
          Cuisine(),
          Camera()
        ],
      ),
    );
  }
}
