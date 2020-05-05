import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/stopwatch.dart';

import 'favorite.dart';

class TimerTable {
  static final String tableTimers = 'timers';
  static final String tableFavorites = 'tableFavorites';
  static final String columnId = '_id';
  static final String columnTitle = 'title';
  static final String columnDuration = 'duration';
  static final String columnFavoriteId = 'favorite_id';
}

class CountdownTimer {
  int id;
  Duration duration;
  String title;
  bool isPlaying = false;
  int favoriteId;
  Stopwatch stopwatch;

  CountdownTimer({@required this.duration, @required this.title}) {
    this.isPlaying = true;
  }

  Map<String, dynamic> toMap({bool asFavorite = false}) {
    var map = <String, dynamic>{
      TimerTable.columnTitle: title,
      TimerTable.columnDuration: duration.inSeconds,
    };
    if (!asFavorite && id != null) {
      map[TimerTable.columnId] = id;
    }
    return map;
  }

  CountdownTimer.fromMap(Map<String, dynamic> map) {
    id = map[TimerTable.columnId];
    title = map[TimerTable.columnTitle];
    duration = Duration(seconds: map[TimerTable.columnDuration]);
    stopwatch = Stopwatch(
        timerId: id, remainingSeconds: map[CountdownTable.columnRemaining]);
    isPlaying = true;
  }

  CountdownTimer.fromFavorite(Favorite favorite) {
    favoriteId = favorite.id;
    title = favorite.title;
    duration = favorite.duration;
    isPlaying = true;
  }
}
