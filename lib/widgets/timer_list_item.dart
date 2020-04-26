import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/widgets/action_icons_column.dart';
import 'package:kitchentimer/widgets/countdown_watch.dart';
import 'package:provider/provider.dart';

class TimerListItem extends StatelessWidget {
  final CountdownTimer countdownTimer;

  TimerListItem({Key key, @required this.countdownTimer})
      : super(
            key: ValueKey(countdownTimer.creationOrder +
                DateTime.now().millisecondsSinceEpoch));

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(countdownTimer.creationOrder.toString()),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(this.countdownTimer.title, style: Styles.title),
                      Container(
                        child: Text(this.countdownTimer.description,
                            style: Styles.label),
                        margin: EdgeInsets.only(top: 4.0),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 16),
                CountdownWatch(countdownTimer: this.countdownTimer),
                SizedBox(width: 16),
                ActionIconsColumn(countdownTimer: this.countdownTimer),
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
