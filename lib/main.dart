import 'package:flutter/material.dart';
import 'package:kitchentimer/providers/timer_provider.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/screens/timer/timer_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.orangeAccent,
      ),
      home: ChangeNotifierProvider(
        create: (context) => TimerProvider(),
        child: TimerScreen(),
      ),
    );
  }
}
