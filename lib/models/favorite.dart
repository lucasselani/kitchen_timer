import 'package:kitchentimer/models/countdown_timer.dart';

class FavoriteTable {
  static final String tableFavorites = 'tableFavorites';
  static final String columnId = '_id';
  static final String columnTitle = 'title';
  static final String columnDuration = 'duration';
}

class Favorite {
  int id;
  Duration duration;
  String title;

  Map<String, dynamic> toMap({bool asTimer = false}) {
    var map = <String, dynamic>{
      FavoriteTable.columnTitle: title,
      FavoriteTable.columnDuration: duration.inSeconds,
    };
    if (!asTimer && id != null) {
      map[FavoriteTable.columnId] = id;
    }
    return map;
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map[FavoriteTable.columnId];
    title = map[FavoriteTable.columnTitle];
    duration = Duration(seconds: map[FavoriteTable.columnDuration]);
  }

  Favorite.fromTimer(CountdownTimer timer) {
    id = timer.favoriteId;
    title = timer.title;
    duration = timer.duration;
  }
}
