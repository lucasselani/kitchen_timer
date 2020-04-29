import 'package:flutter/foundation.dart';

class TimerTable {
  static final String tableFavorite = 'favorite';
  static final String columnId = '_id';
  static final String columnTitle = 'title';
  static final String columnDescription = 'description';
  static final String columnDuration = 'duration';
}

class CountdownTimer {
  int id;
  String description;
  Duration duration;
  int remainingSeconds;
  String title;
  bool isPlaying = false;
  bool isFavorite = false;

  CountdownTimer(
      {@required this.duration, @required this.title, this.description}) {
    this.remainingSeconds = this.duration.inSeconds;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      TimerTable.columnTitle: title,
      TimerTable.columnDescription: description,
      TimerTable.columnDuration: duration.inSeconds,
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
    remainingSeconds = duration.inSeconds;
    isFavorite = true;
  }
}
