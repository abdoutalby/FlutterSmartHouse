import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarthouse/utils/consts.dart';
import 'package:smarthouse/views/timer_setting.dart';

import '../controllers/mqtt_controller.dart';

class TemperatureSonde extends StatefulWidget {
  const TemperatureSonde({super.key});

  @override
  State<TemperatureSonde> createState() => _TemperatureSondeState();
}

class _TemperatureSondeState extends State<TemperatureSonde> {
  double sonde = 0;
  var resistance = true;

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(AppConsts.tempSonde);
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        var json = jsonDecode(pt);
        var msg = message.fromJson(json);
        sonde = msg.sonde!.toDouble();
        resistance = msg.resistance!;
      });
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }

  MQTTClientManager mqttClientManager = MQTTClientManager();

  @override
  void initState() {
    super.initState();
    setupMqttClient();
    setupUpdatesListener();
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text(
          'Sonde',
          style: TextStyle(color: Colors.white),
        ),
        SleekCircularSlider(
          appearance: CircularSliderAppearance(
              infoProperties: InfoProperties(
                  mainLabelStyle: const TextStyle(color: Colors.white)),
              customColors: CustomSliderColors(
                  progressBarColor: Colors.greenAccent,
                  dotColor: Colors.greenAccent,
                  trackColor: Colors.black),
              customWidths:
                  CustomSliderWidths(trackWidth: 15, progressBarWidth: 15)),
          min: 0,
          max: 100,
          initialValue: sonde > 0 ? sonde.toDouble() : 0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'RESISTANCE',
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1,
                            color: resistance ? Colors.red : Colors.green)),
                    child: TextButton(
                        child: Text(
                          resistance ? 'OFF' : "ON",
                          style: TextStyle(
                              color: resistance ? Colors.red : Colors.green),
                        ),
                        onPressed: () => print('off')),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const TimerSetting());
                },
                child: Container(
                  child: Column(
                    children: const [
                      Text(
                        'TIMER',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '60:00:00',
                        style: TextStyle(color: Colors.blue, fontSize: 34),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class message {
  num? sonde;
  bool? resistance;

  message({this.sonde, this.resistance});

  message.fromJson(Map<String, dynamic> json) {
    sonde = json['sonde'];
    resistance = json['resistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sonde'] = sonde;
    data['resistance'] = resistance;
    return data;
  }
}
