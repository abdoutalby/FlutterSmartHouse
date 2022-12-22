import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  var url = "";
  var isLive = false;
  var controller = TextEditingController();
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter IP',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              url = controller.text;
              isLive = true;
            });
          },
          child: const Text("OK"),
        ),
        isLive
            ? Expanded(
                child: WebView(
                  initialUrl: url.isNotEmpty ? url : 'https://google.com',
                ),
              )
            : const SizedBox(
                height: 25,
              ),
      ],
    ));
  }
}
