import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarthouse/utils/consts.dart';

import '../controllers/mqtt_controller.dart';

class Cuisine extends StatefulWidget {
  const Cuisine({super.key});

  @override
  State<Cuisine> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisine> {
  double gaz = 0;

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(AppConsts.cuisine);
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        gaz = double.parse(pt);
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
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Text(
                'Cuisine',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('GAZ'),
                  const SizedBox(
                    height: 50,
                  ),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        customColors: CustomSliderColors(
                            progressBarColor: Colors.amber,
                            dotColor: Colors.amber,
                            trackColor: Colors.black),
                        customWidths: CustomSliderWidths(
                            trackWidth: 15, progressBarWidth: 15)),
                    min: 0,
                    max: 50,
                    initialValue: gaz,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
