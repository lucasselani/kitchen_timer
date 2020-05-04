import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/database_provider.dart';
import 'package:kitchentimer/providers/notification_provider.dart';
import 'package:kitchentimer/resources/strings.dart';

class AppProvider with ChangeNotifier {
  NotificationProvider notificationProvider;
  DatabaseProvider databaseProvider;

  List<CountdownTimer> _timers = [];

  UnmodifiableListView<CountdownTimer> get timers =>
      UnmodifiableListView(_timers);

  UnmodifiableListView<CountdownTimer> get favorites =>
      UnmodifiableListView(_timers.where((t) => t.isFavorite));

  int _sortTimersByElapsedTime(CountdownTimer a, CountdownTimer b) {
    return a.stopwatch.remainingSeconds.compareTo(b.stopwatch.remainingSeconds);
  }

  void _notifyListChanged() {
    if (_timers.length >= 2) _timers.sort(_sortTimersByElapsedTime);
    notifyListeners();
  }

  Future<void> initDb() async {
    await databaseProvider.open();
    _timers = await databaseProvider.list() ?? [];
  }

  Future<void> addTimer(CountdownTimer timer) async {
    _timers.add(timer);
    await databaseProvider.insert(timer);
    _notifyListChanged();
  }

  Future<void> expireTimer(CountdownTimer timer) async {
    _timers.remove(timer);
    notificationProvider.showNotification(Strings.timerExpiredTitle,
        Strings.timerExpiredDescription(timer.title));
    await databaseProvider.delete(timer.id);
    _notifyListChanged();
  }

  Future<void> removeTimer(CountdownTimer timer) async {
    _timers.remove(timer);
    await databaseProvider.delete(timer.id);
    _notifyListChanged();
  }

  Future<void> favoriteTimer(CountdownTimer timer) async {
    timer.isFavorite = !timer.isFavorite;
    await databaseProvider.update(timer);
    notifyListeners();
  }

  void playPauseTimer(CountdownTimer timer) {
    timer.isPlaying = !timer.isPlaying;
    notifyListeners();
  }

  void decrementRemainingTime(CountdownTimer timer) {
    timer.stopwatch.remainingSeconds--;
    databaseProvider.decrementTimer(timer);
  }
}
