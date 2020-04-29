import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/screens/timer/item/action_icons_column.dart';
import 'package:kitchentimer/screens/timer/item/countdown_watch.dart';
import 'package:provider/provider.dart';

class TimerListItem extends StatelessWidget {
  final CountdownTimer countdownTimer;

  TimerListItem({key, @required this.countdownTimer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(countdownTimer),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<AppProvider>(context, listen: false)
            .removeTimer(countdownTimer);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _TextColumn(countdownTimer),
                SizedBox(width: 16),
                CountdownWatch(countdownTimer),
                SizedBox(width: 16),
                ActionIconsColumn(countdownTimer),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: Colors.black12),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  final CountdownTimer countdownTimer;

  _TextColumn(this.countdownTimer);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(countdownTimer.title, style: Styles.title),
          Container(
            child: Text(countdownTimer.description, style: Styles.label),
            margin: EdgeInsets.only(top: 4.0),
          )
        ],
      ),
    );
  }
}
