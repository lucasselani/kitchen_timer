import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationProvider() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettings = InitializationSettings(
        AndroidInitializationSettings('@mipmap/ic_launcher'),
        IOSInitializationSettings());
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future _onSelectNotification(String payload) async {
    print('notification: $payload');
  }

  void showNotification(String title, String description) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'kitchen_timer_id', 'kitchen_timer_channel', 'Kitchen Timer',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(
        0, title, description, platformChannelSpecifics,
        payload: 'Default_Sound');
  }
}
