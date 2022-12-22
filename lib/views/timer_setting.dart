import 'package:flutter/material.dart';

class TimerSetting extends StatefulWidget {
  const TimerSetting({super.key});

  @override
  State<TimerSetting> createState() => _TimerSettingState();
}

class _TimerSettingState extends State<TimerSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timer settings ")),
      body: SafeArea(
          child: Column(
        children: const [],
      )),
    );
  }
}
