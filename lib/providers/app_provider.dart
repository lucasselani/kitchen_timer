import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/notification_provider.dart';
import 'package:kitchentimer/resources/strings.dart';

class AppProvider with ChangeNotifier {
  NotificationProvider notificationProvider;
  final List<CountdownTimer> _timers = [];

  UnmodifiableListView<CountdownTimer> get timers =>
      UnmodifiableListView(_timers);

  int get nextCreationOrder => _timers.length;

  UnmodifiableListView<CountdownTimer> get favorites =>
      timers.where((timer) => timer.isFavorite);
  bool get hasFavorites => favorites.isNotEmpty;

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
    notificationProvider.showNotification(Strings.timerExpiredTitle,
        Strings.timerExpiredDescription(timer.title));
    notifyListeners();
  }
}
