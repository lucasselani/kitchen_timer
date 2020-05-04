import 'package:flutter/foundation.dart';
import 'package:kitchentimer/models/stopwatch.dart';

class TimerTable {
  static final String tableTimers = 'timers';
  static final String columnId = '_id';
  static final String columnTitle = 'title';
  static final String columnDescription = 'description';
  static final String columnDuration = 'duration';
  static final String columnFavorite = 'favorite';
}

class CountdownTimer {
  int id;
  String description;
  Duration duration;
  String title;
  bool isPlaying = false;
  bool isFavorite = false;
  Stopwatch stopwatch;

  CountdownTimer(
      {@required this.duration, @required this.title, this.description}) {
    this.isPlaying = true;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      TimerTable.columnTitle: title,
      TimerTable.columnDescription: description,
      TimerTable.columnDuration: duration.inSeconds,
      TimerTable.columnFavorite: isFavorite ? 1 : 0,
    };
    if (id != null) {
      map[TimerTable.columnId] = id;
    }
    return map;
  }

  CountdownTimer.fromMap(Map<String, dynamic> map) {
    id = map[TimerTable.columnId];
    title = map[TimerTable.columnTitle];
    description = map[TimerTable.columnDescription];
    duration = Duration(seconds: map[TimerTable.columnDuration]);
    isFavorite = map[TimerTable.columnFavorite] == 1 ? true : false;
    stopwatch = Stopwatch(
        timerId: id, remainingSeconds: map[CountdownTable.columnRemaining]);
    isPlaying = true;
  }
}
