import 'package:flutter/material.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/providers/notification_provider.dart';
import 'package:kitchentimer/resources/routes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/resources/themes.dart';
import 'package:kitchentimer/screens/add_timer/add_timer_screen.dart';
import 'package:kitchentimer/screens/timer/timer_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        initialRoute: '/',
        title: Strings.appTitle,
        theme: Themes.appTheme,
        routes: {
          Routes.timerScreen: (context) => TimerScreen(),
          Routes.addTimerScreen: (context) => AddTimerScreen(),
        },
      ),
      providers: [
        Provider(create: (context) => NotificationProvider()),
        ChangeNotifierProxyProvider<NotificationProvider, AppProvider>(
          create: (BuildContext context) => AppProvider(),
          update: (BuildContext context, NotificationProvider notification,
                  AppProvider app) =>
              app..notificationProvider = notification,
        )
      ],
    );
  }
}
