import 'dart:async';

import 'package:kitchentimer/models/countdown_timer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProvider {
  final String _dbName = 'kitchen_timer.db';
  Database _db;

  Future open() async {
    var dbPath = await getDatabasesPath();
    dbPath = join(dbPath, _dbName);
    _db ??= await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table ${TimerTable.tableFavorite} ( 
          ${TimerTable.columnId} integer primary key autoincrement, 
          ${TimerTable.columnTitle} text not null,
          ${TimerTable.columnDescription} text null,
          ${TimerTable.columnDuration} integer not null)
      ''');
    });
  }

  Future<CountdownTimer> insert(CountdownTimer timer) async {
    timer.id = await _db.insert(TimerTable.tableFavorite, timer.toMap());
    return timer;
  }

  Future<CountdownTimer> get(int id) async {
    List<Map> maps = await _db.query(TimerTable.tableFavorite,
        columns: [
          TimerTable.columnId,
          TimerTable.columnTitle,
          TimerTable.columnDescription,
          TimerTable.columnDuration
        ],
        where: '${TimerTable.columnId} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CountdownTimer.fromMap(maps.first);
    }
    return null;
  }

  Future<List<CountdownTimer>> list() async {
    List<Map> maps = await _db.query(TimerTable.tableFavorite, columns: [
      TimerTable.columnId,
      TimerTable.columnTitle,
      TimerTable.columnDescription,
      TimerTable.columnDuration
    ]);
    if (maps.isNotEmpty) {
      return maps.map((t) => CountdownTimer.fromMap(t)).toList();
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(TimerTable.tableFavorite,
        where: '${TimerTable.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(CountdownTimer timer) async {
    return await _db.update(TimerTable.tableFavorite, timer.toMap(),
        where: '${TimerTable.columnId} = ?', whereArgs: [timer.id]);
  }

  Future close() async => _db.close();
}
