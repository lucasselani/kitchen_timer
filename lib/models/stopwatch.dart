import 'package:flutter/foundation.dart';

class CountdownTable {
  static final String tableStopwatch = 'stopwatchs';
  static final String columnId = '_id';
  static final String columnTimerId = 'timer_id';
  static final String columnRemaining = 'remaining';
}

class Stopwatch {
  int id;
  int timerId;
  int remainingSeconds;

  Stopwatch({@required this.timerId, @required this.remainingSeconds});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CountdownTable.columnTimerId: timerId,
      CountdownTable.columnRemaining: remainingSeconds,
    };
    if (id != null) {
      map[CountdownTable.columnId] = id;
    }
    return map;
  }

  Stopwatch.fromMap(Map<String, dynamic> map) {
    id = map[CountdownTable.columnId];
    timerId = map[CountdownTable.columnTimerId];
    remainingSeconds = map[CountdownTable.columnRemaining];
  }
}
