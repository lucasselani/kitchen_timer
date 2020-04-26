import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';

class AppProvider with ChangeNotifier {
  final List<CountdownTimer> _timers = [];

  UnmodifiableListView<CountdownTimer> get timers =>
      UnmodifiableListView(_timers);

  final List<CountdownTimer> _favoriteTimers = [];

  int get nextCreationOrder => _timers.length;

  int _sortTimersByElapsedTime(CountdownTimer a, CountdownTimer b) {
    return a.remainingSeconds.compareTo(b.remainingSeconds);
  }

  void addTimer(CountdownTimer timer) {
    _timers.add(timer);
    if (_timers.length >= 2) _timers.sort(_sortTimersByElapsedTime);
    notifyListeners();
  }

  void removeTimer(CountdownTimer timer) {
    _timers.remove(timer);
    if (_timers.length >= 2) _timers.sort(_sortTimersByElapsedTime);
    notifyListeners();
  }

  void favoriteTimer(CountdownTimer timer) {
    timer.isFavorite = !timer.isFavorite;
    _favoriteTimers.contains(timer)
        ? _favoriteTimers.remove(timer)
        : _favoriteTimers.add(timer);
    notifyListeners();
  }

  void playPauseTimer(CountdownTimer timer) {
    timer.isPlaying = !timer.isPlaying;
    notifyListeners();
  }
}
