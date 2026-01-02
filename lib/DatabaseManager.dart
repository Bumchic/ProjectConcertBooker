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
        Seat realSeats = await GetSeatArray(concert['id']);
        todolist.add(
          Concert(
            id: concert['id'],
            name: concert['name'],
            date: concert['date'],
            price: (concert['price'] as int).toDouble(),
            imagelink: concert['imagelink'],
            seats: realSeats,
          ),
        );
      }
      return todolist;
    } catch (Exception) {
      throw Exception;
    }
  }

  Future<Seat> GetSeatArray(int id) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> databaseseatlist = await db.query("Seat", where: "concertID = ?", whereArgs: [id]);
      (int, int) counttuple   = GetLargestSeat(databaseseatlist);
      int horizontalcount = counttuple.$1;
      int verticalcount = counttuple.$2;
      List<List<int>> seatarray = List.generate(horizontalcount + 1, (i) => List.generate(verticalcount + 1, (j) => 0));
      for(Map<String,dynamic> seat in databaseseatlist)
      {
          seatarray[seat["verticalPos"]][seat["horizontalPos"]] = seat["available"];
      }

      return Seat(seathorizontalamount: horizontalcount+1, seatvertivalamount: verticalcount+1, seatarray: seatarray);
    } catch (Exception) {
      throw Exception;
    }
  }

  (int, int) GetLargestSeat(List<Map<String, dynamic>> databaseseatlist)
  {
    (int, int) res = (0,0);
    for(Map<String, dynamic> seat in databaseseatlist)
      {
        int num1 = res.$1;
        int num2 = res.$2;
        if(seat["verticalPos"] > res.$1)
          {
            num1 = seat["verticalPos"];
          }
        if(seat["horizontalPos"] > res.$2)
          {
            num2 = seat["horizontalPos"];
          }
        res = (num1, num2);
      }
    return res;
  }


  Future<void> AddConcert(Concert concert) async {
    try {
      Database db = await database;
      int id = await db.insert("Concert", concert.ToMap());

      for(int i=0; i < concert.seats.seathorizontalamount; i++)
        {
          for(int j=0; j< concert.seats.seatvertivalamount; j++)
            {
              Map<String, dynamic> seatdata
               = {
                "concertID" : id,
                 "verticalPos" : i,
                 "horizontalPos": j,
                 "available": concert.seats.seatarray[i][j]
               };
              db.insert("Seat", seatdata);
            }
        }
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
      join(await getDatabasesPath(), 'concertdb.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute("PRAGMA foreign_keys = ON");
        await db.execute("""
        CREATE TABLE Concert(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          date TEXT,
          description TEXT,
          price INTEGER,
          imagelink TEXT
        )
      """);
        await db.execute("""
        CREATE TABLE Seat(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          concertID INTEGER,
          verticalPos INTEGER NOT NULL,
          horizontalPos INTEGER NOT NULL,
          available INTEGER NOT NULL,
          FOREIGN KEY (concertID) REFERENCES Concert(id)
        )
      """);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("""
          CREATE TABLE IF NOT EXISTS Concert(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            date TEXT,
            description TEXT,
            price INTEGER,
            imagelink TEXT
          )
        """);
          await db.execute("""
          CREATE TABLE IF NOT EXISTS Seat(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            concertID INTEGER,
            verticalPos INTEGER NOT NULL,
            horizontalPos INTEGER NOT NULL,
            available INTEGER NOT NULL,
            FOREIGN KEY (concertID) REFERENCES Concert(id)
          )
        """);
        }
      },
    );
  }

}
