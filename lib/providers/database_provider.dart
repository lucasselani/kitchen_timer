import 'dart:async';

import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:kitchentimer/models/favorite.dart';
import 'package:kitchentimer/models/stopwatch.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  final String _dbName = 'kitchen_timer.db';
  Database _db;

  Future open() async {
    var dbPath = await getDatabasesPath();
    dbPath = join(dbPath, _dbName);
    _db ??= await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table ${TimerTable.tableTimers} ( 
          ${TimerTable.columnId} integer primary key autoincrement, 
          ${TimerTable.columnTitle} text not null,
          ${TimerTable.columnDuration} integer not null,
          ${TimerTable.columnFavoriteId} integer null)
      ''');
      await db.execute('''
        create table ${TimerTable.tableFavorites} ( 
          ${TimerTable.columnId} integer primary key autoincrement, 
          ${TimerTable.columnTitle} text not null,
          ${TimerTable.columnDuration} integer not null)
      ''');
      await db.execute('''
         create table ${CountdownTable.tableStopwatch} ( 
          ${CountdownTable.columnId} integer primary key autoincrement, 
          ${CountdownTable.columnRemaining} integer not null,
          ${CountdownTable.columnTimerId} integer not null,
          FOREIGN KEY (${CountdownTable.columnTimerId}) 
          REFERENCES ${TimerTable.tableTimers} (${TimerTable.columnId}) 
          ON UPDATE CASCADE
          ON DELETE CASCADE
          )
      ''');
    });
  }

  Future<List<CountdownTimer>> insertFromFavorites(
      List<Favorite> favorites) async {
    List<CountdownTimer> timers = [];
    await Future.wait(favorites.map((favorite) async {
      CountdownTimer timer =
          await insert(CountdownTimer.fromFavorite(favorite));
      timers.add(timer);
    }));
    return timers;
  }

  Future<CountdownTimer> insert(CountdownTimer timer) async {
    timer.id = await _db.insert(TimerTable.tableTimers, timer.toMap());
    var stopwatch = Stopwatch(
        timerId: timer.id, remainingSeconds: timer.duration.inSeconds);
    timer.stopwatch = stopwatch
      ..id = await _db.insert(CountdownTable.tableStopwatch, stopwatch.toMap());
    return timer;
  }

  Future<List<CountdownTimer>> list() async {
    List<Map> timers = await _db.rawQuery(''' 
      SELECT * FROM ${TimerTable.tableTimers} as t
      INNER JOIN ${CountdownTable.tableStopwatch} as c
      ON t.${TimerTable.columnId} = c.${CountdownTable.columnTimerId}
    ''');
    return timers.map((t) => CountdownTimer.fromMap(t)).toList();
  }

  Future<List<Favorite>> favorites() async {
    List<Map> favorites = await _db.query(TimerTable.tableFavorites);
    return favorites.map((t) => Favorite.fromMap(t)).toList();
  }

  Future<int> delete(int id) async {
    return await _db.delete(TimerTable.tableTimers,
        where: '${TimerTable.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(CountdownTimer timer) async {
    return await _db.update(TimerTable.tableTimers, timer.toMap(),
        where: '${TimerTable.columnId} = ?', whereArgs: [timer.id]);
  }

  Future<Favorite> favoriteTimer(CountdownTimer timer) async {
    if (timer.favoriteId == null) {
      timer.favoriteId = await _db.insert(
          TimerTable.tableFavorites, timer.toMap(asFavorite: true));
      return Favorite.fromTimer(timer);
    } else {
      await _db.delete(TimerTable.tableFavorites,
          where: '${TimerTable.columnId} = ?', whereArgs: [timer.favoriteId]);
      timer.favoriteId = null;
      return null;
    }
  }

  Future<int> deleteFavorite(Favorite favorite) async {
    return await _db.delete(TimerTable.tableFavorites,
        where: '${TimerTable.columnId} = ?', whereArgs: [favorite.id]);
  }

  Future<int> decrementTimer(CountdownTimer timer) async {
    return await _db.update(CountdownTable.tableStopwatch,
        {CountdownTable.columnRemaining: timer.stopwatch.remainingSeconds},
        where: '${CountdownTable.columnTimerId} = ?', whereArgs: [timer.id]);
  }

  Future close() async => _db.close();
}
