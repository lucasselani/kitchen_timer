import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';

import 'app_provider.dart';

class TimerProvider with ChangeNotifier {
  bool isRunning = false;
  Timer _timer;
  CountdownTimer countdownTimer;
  AppProvider _appProvider;

  AppProvider get appProvider => _appProvider;

  set appProvider(AppProvider provider) {
    _appProvider = provider;
    notifyListeners();
  }

  TimerProvider({@required this.countdownTimer}) {
    countdownTimer.isPlaying = true;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void checkTimer() {
    if (_timer != null && !countdownTimer.isPlaying) {
      _stopTimer();
    } else if (_timer == null && countdownTimer.isPlaying) {
      _initTimer();
    }
  }

  void _initTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) async {
        if (countdownTimer.stopwatch.remainingSeconds < 1) {
          timer.cancel();
          await appProvider.expireTimer(countdownTimer);
        } else {
          appProvider.decrementRemainingTime(countdownTimer);
          notifyListeners();
        }
      },
    );
  }

  void _stopTimer() {
    _timer.cancel();
    _timer = null;
  }
}
