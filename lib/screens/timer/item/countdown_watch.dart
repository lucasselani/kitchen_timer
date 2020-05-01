import 'package:flutter/material.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/providers/timer_provider.dart';
import 'package:kitchentimer/resources/colors.dart';
import 'package:kitchentimer/resources/styles.dart';
import 'package:kitchentimer/utils/timeUtils.dart';
import 'package:provider/provider.dart';

class CountdownWatch extends StatelessWidget {
  final CountdownTimer countdownTimer;

  CountdownWatch(this.countdownTimer);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AppProvider, TimerProvider>(
      create: (_) => TimerProvider(countdownTimer: countdownTimer),
      update: (_, AppProvider app, TimerProvider timer) =>
          timer..appProvider = app,
      child: Consumer<TimerProvider>(
        builder: (_, TimerProvider provider, ___) {
          provider.checkTimer();
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator(
                    backgroundColor: AppColors.black12,
                    strokeWidth: 2.5,
                    value: 1 -
                        provider.countdownTimer.remainingSeconds /
                            provider.countdownTimer.duration.inSeconds,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.red300)),
              ),
              Container(
                child: Text(
                  formatTime(countdownTimer.remainingSeconds),
                  style: Styles.watch,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
