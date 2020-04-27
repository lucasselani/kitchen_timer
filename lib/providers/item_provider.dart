import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';

import 'app_provider.dart';

class ItemProvider with ChangeNotifier {
  Timer _timer;
  CountdownTimer countdownTimer;
  AppProvider _appProvider;

  AppProvider get appProvider => _appProvider;

  set appProvider(AppProvider provider) {
    _appProvider = provider;
    notifyListeners();
  }

  ItemProvider({@required this.countdownTimer}) {
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if(!countdownTimer.isPlaying) {
          timer.cancel();
          notifyListeners();
          return;
        }
        if (countdownTimer.remainingSeconds < 1) {
          timer.cancel();
          appProvider.removeTimer(countdownTimer);
        } else {
          countdownTimer.remainingSeconds--;
          notifyListeners();
        }
      },
    );
  }

  void favoriteTimer() {
    countdownTimer.isFavorite = !countdownTimer.isFavorite;
    notifyListeners();
  }

  void playPauseTimer() {
    countdownTimer.isPlaying = !countdownTimer.isPlaying;
    if (countdownTimer.isPlaying) {
      _startTimer();
    } else {
      _timer.cancel();
    }
    notifyListeners();
  }
}
