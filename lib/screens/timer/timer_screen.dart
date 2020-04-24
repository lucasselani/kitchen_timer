import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/timer_provider.dart';
import 'package:kitchentimer/resources/routes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/widgets/timer_list_item.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  List<Widget> _createListItems(TimerProvider provider) {
    return provider.timers
        .map((CountdownTimer timer) => TimerListItem(timer: timer))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (BuildContext context, TimerProvider provider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(Strings.timerTitle),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: _createListItems(provider),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addTimerScreen);
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
