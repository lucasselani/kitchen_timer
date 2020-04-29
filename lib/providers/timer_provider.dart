import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';

import 'app_provider.dart';

class TimerProvider with ChangeNotifier {
  Timer _timer;
  CountdownTimer countdownTimer;
  AppProvider _appProvider;

  AppProvider get appProvider => _appProvider;

  set appProvider(AppProvider provider) {
    _appProvider = provider;
    notifyListeners();
  }

  TimerProvider({@required this.countdownTimer}) {
    _initTimer();
  }

  void checkTimer() {
    if (_timer.isActive && !countdownTimer.isPlaying) {
      _timer.cancel();
    } else if (!_timer.isActive && countdownTimer.isPlaying) {
      _initTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (countdownTimer.remainingSeconds < 1) {
          timer.cancel();
          appProvider.expireTimer(countdownTimer);
        } else {
          countdownTimer.remainingSeconds--;
          notifyListeners();
        }
      },
    );
  }
}
