import 'package:flutter/foundation.dart';

class CountdownTimer {
  int _creationOrder = -1;

  int get creationOrder => _creationOrder;

  String description;
  Duration duration;
  int remainingSeconds;
  String title;
  bool isPlaying = true;
  bool isFavorite = false;

  CountdownTimer(
      {@required int creationOrder,
      @required this.duration,
      @required this.title,
      this.description}) {
    this._creationOrder = creationOrder;
    this.remainingSeconds = this.duration.inSeconds;
  }
}
