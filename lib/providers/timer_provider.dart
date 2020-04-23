import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/timer.dart';

class TimerProvider with ChangeNotifier {
  final List<Timer> _timers = [];
  UnmodifiableListView<Timer> get timers => UnmodifiableListView(_timers);

  void reorderList(int oldIndex, int newIndex) {
    var timer = _timers.removeAt(oldIndex);
    _timers.insert(newIndex - 1, timer);
    notifyListeners();
  }

  void addTimer(Timer timer) {
    timer.id = _timers.length + 1;
    _timers.add(timer);
    notifyListeners();
  }
}
