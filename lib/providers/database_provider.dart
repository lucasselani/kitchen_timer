import 'dart:async';

import 'package:kitchentimer/models/countdown_timer.dart';
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
          ${TimerTable.columnDescription} text null,
          ${TimerTable.columnDuration} integer not null,
          ${TimerTable.columnFavorite} integer not null)
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

  Future<CountdownTimer> insert(CountdownTimer timer) async {
    timer.id = await _db.insert(TimerTable.tableTimers, timer.toMap());
    var stopwatch = Stopwatch(
        timerId: timer.id, remainingSeconds: timer.duration.inSeconds);
    timer.stopwatch = stopwatch
      ..id = await _db.insert(CountdownTable.tableStopwatch, stopwatch.toMap());
    return timer;
  }

  Future<List<CountdownTimer>> list() async {
    List<Map> maps = await _db.rawQuery(''' 
      SELECT * FROM ${TimerTable.tableTimers} as t
      INNER JOIN ${CountdownTable.tableStopwatch} as c
      ON t.${TimerTable.columnId} = c.${CountdownTable.columnTimerId}
    ''');
    if (maps.isNotEmpty) {
      return maps.map((t) => CountdownTimer.fromMap(t)).toList();
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(TimerTable.tableTimers,
        where: '${TimerTable.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(CountdownTimer timer) async {
    return await _db.update(TimerTable.tableTimers, timer.toMap(),
        where: '${TimerTable.columnId} = ?', whereArgs: [timer.id]);
  }

  Future<int> decrementTimer(CountdownTimer timer) async {
    return await _db.update(CountdownTable.tableStopwatch,
        {CountdownTable.columnRemaining: timer.stopwatch.remainingSeconds},
        where: '${CountdownTable.columnTimerId} = ?', whereArgs: [timer.id]);
  }

  Future close() async => _db.close();
}
