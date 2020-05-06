import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationProvider() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettings = InitializationSettings(
        AndroidInitializationSettings('ic_stat_notification_icon'),
        IOSInitializationSettings());
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future _onSelectNotification(String payload) async {
    print('notification: $payload');
  }

  void showNotification(String title, String description, int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'multi_temporizadores_id',
        'multi_temporizadores_channel',
        'Temporizadores',
        groupKey: 'multi_temporizadores_group',
        importance: Importance.Max,
        priority: Priority.High,
        color: Colors.transparent,
        enableLights: true,
        enableVibration: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin
        .show(id, title, description, platformChannelSpecifics, payload: title);
  }
}
