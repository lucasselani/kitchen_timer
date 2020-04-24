import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/timer.dart';

class TimerProvider with ChangeNotifier {
  final List<Timer> _timers = [];
  UnmodifiableListView<Timer> get timers => UnmodifiableListView(_timers);
  int get nextCreationOrder => _timers.length;

  int sortTimersByElapsedTime(Timer a, Timer b) {
    return a.elapsedTime.compareTo(b.elapsedTime);
  }

  void addTimer(Timer timer) {
    _timers.add(timer);
    //_timers.sort(sortTimersByElapsedTime);
    notifyListeners();
  }
}
