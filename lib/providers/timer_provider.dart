import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/timer.dart';

class TimerProvider with ChangeNotifier {
  final List<Timer> _timers = [];
  UnmodifiableListView<Timer> get timers => UnmodifiableListView(_timers);

  void addTimer(Timer timer) {
    timer.id = _timers.length + 1;
    _timers.add(timer);
    notifyListeners();
  }
}
