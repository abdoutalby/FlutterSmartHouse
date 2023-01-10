import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class notifyAPI{

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id' ,
          'channel name' ,
          channelDescription: 'channel description',
          importance: Importance.max,
          icon: '@mipmap/ic_launcher'
      ) ,

    );
  }

  static final _notifications = FlutterLocalNotificationsPlugin();
  static Future showNotification({int id = 0 ,String? title, String? body, String? payload }) async =>
     _notifications.show(id, title, body,await notificationDetails() , payload: payload);

  static Future init ({bool initScheduled = false }) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(settings,
      onDidReceiveNotificationResponse: (payload) async{
      
      }
    );
  }

}