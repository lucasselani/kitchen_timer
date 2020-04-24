import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class _TimerListItemState extends State<TimerListItem> {
  CountdownTimer countdownTimer;
  Timer _timer;

  _TimerListItemState({@required this.countdownTimer}) {
    _startTimer();
  }

  @override
  void dispose() {
    this._timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (countdownTimer.remainingSeconds < 1) {
          timer.cancel();
          Provider.of<TimerProvider>(context, listen: false)
              .removeTimer(countdownTimer);
        } else {
          setState(() {
            countdownTimer.remainingSeconds--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(countdownTimer.remainingSeconds.toString()),
                SizedBox(width: 24),
                Expanded(
                  child: Text(this.countdownTimer.title),
                ),
                SizedBox(width: 24),
              ],
            ),
            Divider(color: Colors.black45),
          ],
        ),
      ),
    );
  }
}

class TimerListItem extends StatefulWidget {
  final CountdownTimer timer;

  TimerListItem({Key key, @required this.timer})
      : super(
            key: ValueKey(
                timer.creationOrder + DateTime.now().millisecondsSinceEpoch));

  @override
  State<StatefulWidget> createState() {
    return _TimerListItemState(countdownTimer: timer);
  }
}
