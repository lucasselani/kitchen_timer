import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/utils/timeUtils.dart';
import 'package:provider/provider.dart';

class CountdownWatch extends StatefulWidget {
  final CountdownTimer countdownTimer;

  CountdownWatch({@required this.countdownTimer});

  @override
  State<StatefulWidget> createState() {
    return _CountdownWatchState(countdownTimer: countdownTimer);
  }
}

class _CountdownWatchState extends State<CountdownWatch> {
  Timer _timer;
  CountdownTimer countdownTimer;
  int remainingSeconds;

  _CountdownWatchState({@required this.countdownTimer}) {
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
        if (!countdownTimer.isPlaying) {
          timer.cancel();
          return;
        }
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
      child: Text(
        formatTime(countdownTimer.remainingSeconds),
        style: Styles.watch,
      ),
    );
  }
}
