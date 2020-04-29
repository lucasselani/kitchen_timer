import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/providers/favorite_provider.dart';
import 'package:kitchentimer/providers/notification_provider.dart';
import 'package:kitchentimer/resources/strings.dart';

class AppProvider with ChangeNotifier {
  NotificationProvider notificationProvider;
  FavoriteProvider favoriteProvider;

  final List<CountdownTimer> _timers = [];

  UnmodifiableListView<CountdownTimer> get timers =>
      UnmodifiableListView(_timers);

  int get nextCreationOrder => _timers.length;

  List<CountdownTimer> get favorites =>
      _timers.where((timer) => timer.isFavorite).toList();
  bool get hasFavorites => favorites.isNotEmpty;

  int _sortTimersByElapsedTime(CountdownTimer a, CountdownTimer b) {
    return a.remainingSeconds.compareTo(b.remainingSeconds);
  }

  void _notifyListChanged() {
    if (_timers.length >= 2) _timers.sort(_sortTimersByElapsedTime);
    notifyListeners();
  }

  void addTimer(CountdownTimer timer) {
    _timers.add(timer);
    _notifyListChanged();
  }

  void expireTimer(CountdownTimer timer) {
    _timers.remove(timer);
    notificationProvider.showNotification(Strings.timerExpiredTitle,
        Strings.timerExpiredDescription(timer.title));
    _notifyListChanged();
  }

  void removeTimer(CountdownTimer timer) {
    _timers.remove(timer);
    _notifyListChanged();
  }

  void favoriteTimer(CountdownTimer timer) async {
    timer.isFavorite = !timer.isFavorite;
    if (timer.isFavorite) {
      await favoriteProvider.insert(timer);
    } else {
      await favoriteProvider.delete(timer.id);
    }
    notifyListeners();
  }

  void playPauseTimer(CountdownTimer timer) {
    timer.isPlaying = !timer.isPlaying;
    notifyListeners();
  }
}
