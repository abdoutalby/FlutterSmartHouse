import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarthouse/controllers/mqtt_controller.dart';
import 'package:smarthouse/utils/consts.dart';

class TemperatureExterieure extends StatefulWidget {
  const TemperatureExterieure({super.key});

  @override
  State<TemperatureExterieure> createState() => _TemperatureExterieureState();
}

class _TemperatureExterieureState extends State<TemperatureExterieure> {
  double temperature = 0;
  double humidity = 0;

  @override
  void initState() {
    super.initState();

    setupMqttClient();
    //setupUpdatesListener();
  }

  Future<void> setupMqttClient() async {
if(    await InternetConnectionChecker().hasConnection ){
  await mqttClientManager.connect();
  mqttClientManager.subscribe(AppConsts.tempExt);

}else {
  Get.defaultDialog(title: "no internet");

}

  }

  MQTTClientManager mqttClientManager = MQTTClientManager();

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
        temperature = msg.temperature !=null ?  msg.temperature!.toDouble(): 0;
        humidity = msg.humidity !=null ? msg.humidity!.toDouble(): 0;
      });

      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Text(
                'TemperatureExterieure',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      const Text('Temperature'),
                      const SizedBox(
                        height: 50,
                      ),
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            infoProperties: InfoProperties(
                                mainLabelStyle:
                                    const TextStyle(color: Colors.white)),
                            customColors: CustomSliderColors(
                                progressBarColor: Colors.amber,
                                dotColor: Colors.amber,
                                trackColor: Colors.black),
                            customWidths: CustomSliderWidths(
                                trackWidth: 15, progressBarWidth: 15)),
                        min: 0,
                        max: 100,
                        initialValue: temperature.toDouble(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Humidite'),
                      const SizedBox(
                        height: 50,
                      ),
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            infoProperties: InfoProperties(
                                mainLabelStyle:
                                    const TextStyle(color: Colors.white)),
                            customColors: CustomSliderColors(
                                progressBarColor: Colors.blue,
                                dotColor: Colors.blue,
                                trackColor: Colors.black),
                            customWidths: CustomSliderWidths(
                                trackWidth: 15, progressBarWidth: 15)),
                        min: 0,
                        max: 100,
                        initialValue: humidity.toDouble(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class message {
  num? humidity;
  num? temperature;

  message({this.humidity, this.temperature});

  message.fromJson(Map<String, dynamic> json) {
    humidity = json['humidity'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['humidity'] = humidity;
    data['temperature'] = temperature;
    return data;
  }
}
