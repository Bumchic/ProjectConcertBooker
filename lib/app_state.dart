import 'package:concertbooker/DatabaseManager.dart';
import 'package:flutter/material.dart';
import 'package:concertbooker/Concert.dart';
import 'package:concertbooker/Seat.dart';

class AppState extends ChangeNotifier {
  bool isAdminMode = false;
  Databasemanager dbmanager = Databasemanager(database: Databasemanager.InitDatabase());

  void toggleAdminMode() {
    isAdminMode = !isAdminMode;
    notifyListeners();
  }

  void addConcert(String name, String imageLink, int rows, int columns, String date, double price) {
    final newSeat = Seat(
      seathorizontalamount: rows,
      seatvertivalamount: columns,
    );

    final newConcert = Concert(
      name: name,
      imagelink: imageLink,
      seats: newSeat,
      date: date,
      price: price,
    );

    //concerts.add(newConcert);
    dbmanager.AddConcert(newConcert);
    notifyListeners();
  }
}