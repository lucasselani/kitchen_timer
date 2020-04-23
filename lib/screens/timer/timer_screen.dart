import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/timer.dart';
import 'package:kitchentimer/providers/timer_provider.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/widgets/timer_list_item.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  List<Widget> _createListItems(TimerProvider provider) {
    return provider.timers.map((timer) => TimerListItem(timer: timer)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.timerTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TimerProvider>(
          builder:
              (BuildContext context, TimerProvider provider, Widget child) {
            return ReorderableListView(
              children: _createListItems(provider),
              onReorder: (int oldIndex, int newIndex) {
                provider.reorderList(oldIndex, newIndex);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<TimerProvider>(context, listen: false).addTimer(Timer());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
