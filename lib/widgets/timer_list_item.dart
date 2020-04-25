import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:provider/provider.dart';

class TimerListItem extends StatelessWidget {
  final CountdownTimer countdownTimer;

  TimerListItem({Key key, @required this.countdownTimer})
      : super(
            key: ValueKey(countdownTimer.creationOrder +
                DateTime.now().millisecondsSinceEpoch));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 64,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                _Watch(countdownTimer: this.countdownTimer),
                SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(this.countdownTimer.title),
                      Text(this.countdownTimer.description ?? '')
                    ],
                  ),
                ),
                SizedBox(width: 24),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}

class _Watch extends StatefulWidget {
  final CountdownTimer countdownTimer;

  _Watch({@required this.countdownTimer});

  @override
  State<StatefulWidget> createState() {
    return _WatchState(countdownTimer: countdownTimer);
  }
}

class _WatchState extends State<_Watch> {
  Timer _timer;
  CountdownTimer countdownTimer;
  int remainingSeconds;

  _WatchState({@required this.countdownTimer}) {
    remainingSeconds = countdownTimer.remainingSeconds;
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
          Provider.of<AppProvider>(context, listen: false)
              .removeTimer(countdownTimer);
        } else {
          countdownTimer.remainingSeconds--;
          setState(() {
            remainingSeconds--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            countdownTimer.remainingSeconds.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
