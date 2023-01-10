import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smarthouse/controllers/mqtt_controller.dart';
import 'package:smarthouse/utils/Notification.dart';

class Salon extends StatefulWidget {
  const Salon({super.key});

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> {
  bool lampe = false;

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe("smarthouse/notify");
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      lampePressed();
        });
  }

  MQTTClientManager mqttClientManager = MQTTClientManager();

  @override
  void initState() {
    super.initState();
    setupMqttClient();
    setupUpdatesListener();
  }

  lampePressed() {
    lampe = true;
    notifyAPI.showNotification(title: "House Seciruty Alert",body: " mouvement detected in your house you want to check" , payload: "lampe");
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(children: [
            Text(lampe?'Mouvement Detected': ""),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1, color: lampe ? Colors.green : Colors.red)),
            child: TextButton(
                onPressed: (){},
                child: Text(
                  lampe ? 'OFF' : "ON",
                  style: TextStyle(color: lampe ? Colors.red : Colors.green),
                )),
          )
        ]),
      )),
    );
  }
}
