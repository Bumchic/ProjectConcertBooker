import 'package:flutter/material.dart';
import 'package:concertbooker/Concert.dart';
import 'package:concertbooker/Seat.dart';

class AppState extends ChangeNotifier {
  bool isAdminMode = false;
  List<Concert> concerts = [];
  void toggleAdminMode() {
    isAdminMode = !isAdminMode;
    notifyListeners();
  }

  void addConcert(String name, String imageLink, int rows, int columns) {
    final newSeat = Seat(
      seathorizontalamount: rows,
      seatvertivalamount: columns,
    );
    final newConcert = Concert(
      id: concerts.isEmpty ? 1 : concerts.last.id + 1,
      name: name,
      imagelink: imageLink,
      seats: newSeat,
    );

    concerts.add(newConcert);
    notifyListeners();
  }
}
