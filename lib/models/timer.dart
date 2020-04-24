import 'package:flutter/foundation.dart';

class Timer {
  Duration _elapsedTime;

  int get elapsedTime => _elapsedTime.inMilliseconds;

  int _creationOrder = -1;

  int get creationOrder => _creationOrder;

  String description;
  Duration duration;
  String title;

  Timer(this._creationOrder,
      {@required this.duration, @required this.title, this.description});
}
