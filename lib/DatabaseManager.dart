import 'package:concertbooker/Concert.dart';
import 'package:concertbooker/Seat.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';


class Databasemanager {
  Future<Database> database;
  Databasemanager({required this.database});

  Future<List<Concert>> GetConcertList() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> databaseconcertlist = await db.query(
        "Concert",
      );
      List<Concert> todolist = [];
      for (Map<String, dynamic> concert in databaseconcertlist) {
        todolist.add(
          Concert(
            id: concert['id'],
            name: concert['name'],
            date: concert['date'],
            price: concert['price'],
            imagelink: concert['imagelink'],
            seats: Seat(),
          ),
        );
      }
      return todolist;
    } catch (Exception) {
      throw Exception;
    }
  }

  Future<void> AddConcert(Concert concert) async {
    try {
      Database db = await database;
      db.insert("Concert", concert.ToMap());
    } catch (Exception) {
      throw Exception;
    }
  }

  Future<void> DeleteConcert(Concert concert) async {
    try {
      Database db = await database;
      db.delete("Concert", where: "id = ?", whereArgs: [concert.id]);
    } catch (Exception) {
      throw Exception;
    }
  }

  static Future<Database> InitDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
        join(await getDatabasesPath(), 'concertdbtest.db'),
        onCreate: (db, version) {
          db.execute("PRAGMA foreign_keys = ON");
          db.execute(
            'create table Concert(id integer num AUTOINCREMENT primary key, name text not null, date text, description text, price integer, imagelink text);',
          );
          db.execute(
            'create table seat(id integer AUTOINCREMENT primary key, concertID integer, verticalPos integer not null, horizontalPos integer not null'
                'foreign key (concertID) references Concert(id))',
          );
          db.insert('Concert', Concert( name: 'name', date: "2025-01-01", price: 4, imagelink: "hello", seats: Seat()).ToMap());
        },
        version: 1
    );
  }
}
