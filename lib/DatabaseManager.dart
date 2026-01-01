import 'package:concertbooker/Concert.dart';
import 'package:concertbooker/Seat.dart';
import 'package:sqflite/sqflite.dart';

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
}
