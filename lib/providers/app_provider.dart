import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/models/favorite.dart';
import 'package:kitchentimer/providers/database_provider.dart';
import 'package:kitchentimer/providers/notification_provider.dart';
import 'package:kitchentimer/resources/strings.dart';

class AppProvider with ChangeNotifier {
  NotificationProvider notificationProvider;
  DatabaseProvider databaseProvider;

  List<CountdownTimer> _timers = [];

  UnmodifiableListView<CountdownTimer> get timers =>
      UnmodifiableListView(_timers);

  List<Favorite> _favorites = [];

  UnmodifiableListView<Favorite> get favorites =>
      UnmodifiableListView(_favorites);

  int _sortTimersByElapsedTime(CountdownTimer a, CountdownTimer b) {
    return a.stopwatch.remainingSeconds.compareTo(b.stopwatch.remainingSeconds);
  }

  void _notifyListChanged() {
    if (_timers.length >= 2) _timers.sort(_sortTimersByElapsedTime);
    notifyListeners();
  }

  Future<void> initDb() async {
    await databaseProvider.open();
    _favorites = await databaseProvider.favorites() ?? [];
    _timers = await databaseProvider.list() ?? [];
  }

  Future<void> addTimer(CountdownTimer timer) async {
    await databaseProvider.insert(timer);
    _timers.add(timer);
    _notifyListChanged();
  }

  Future<void> addTimers(List<Favorite> favorites) async {
    var timers = await databaseProvider.insertFromFavorites(favorites);
    _timers.addAll(timers);
    _notifyListChanged();
  }

  Future<void> expireTimer(CountdownTimer timer) async {
    await databaseProvider.delete(timer.id);
    _timers.remove(timer);
    notificationProvider.showNotification(Strings.timerExpiredTitle,
        Strings.timerExpiredDescription(timer.title), timer.id);
    _notifyListChanged();
  }

  Future<void> removeTimer(CountdownTimer timer) async {
    await databaseProvider.delete(timer.id);
    _timers.remove(timer);
    _notifyListChanged();
  }

  Future<void> favoriteTimer(CountdownTimer timer) async {
    var oldId = timer.favoriteId;
    if (oldId != null) {
      _favorites.removeWhere((f) => f.id == timer.favoriteId);
    }
    Favorite favorite = await databaseProvider.favoriteTimer(timer);
    if (favorite != null) {
      _favorites.add(favorite);
    } else {
      _timers.forEach((t) {
        if (t.favoriteId == oldId) {
          t.favoriteId = null;
        }
      });
    }
    notifyListeners();
  }

  Future<void> deleteFavorite(Favorite favorite) async {
    _favorites.removeWhere((f) => f.id == favorite.id);
    _timers.forEach((t) {
      if (t.favoriteId == favorite.id) t.favoriteId = null;
    });
    await databaseProvider.deleteFavorite(favorite);
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
