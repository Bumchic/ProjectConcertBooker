import 'package:concertbooker/DatabaseManager.dart';
import 'package:flutter/material.dart';
import 'package:concertbooker/Concert.dart';
import 'package:concertbooker/Seat.dart';

class AppState extends ChangeNotifier {
  bool isAdminMode = false;
  Databasemanager dbmanager = Databasemanager(database: Databasemanager.InitDatabase());
  List<Concert> concerts = [
    Concert(
      id: 1,
      name: "The Eras Tour - Taylor Swift",
      imagelink: "https://upload.wikimedia.org/wikipedia/en/4/4d/The_Eras_Tour_poster.png",
      date: "02/03/2026",
      price: 1200.0,
      seats: Seat(seathorizontalamount: 20, seatvertivalamount: 30),

    ),
    Concert(
      id: 2,
      name: "Born Pink World Tour - BLACKPINK",
      imagelink: "https://upload.wikimedia.org/wikipedia/en/2/23/Blackpink_Born_Pink_World_Tour_poster.jpg",
      date: "15/04/2026",
      price: 850.0,
      seats: Seat(seathorizontalamount: 15, seatvertivalamount: 25),
    ),
    Concert(
      id: 3,
      name: "Music of the Spheres - Coldplay",
      imagelink: "https://upload.wikimedia.org/wikipedia/en/2/2f/Music_of_the_Spheres_World_Tour_poster.jpg",
      date: "20/05/2026",
      price: 900.0,
      seats: Seat(seathorizontalamount: 25, seatvertivalamount: 25),
    ),
    Concert(
      id: 4,
      name: "Sky Tour 2026 - Son Tung M-TP",
      imagelink: "https://upload.wikimedia.org/wikipedia/vi/6/62/Sky_Tour_Movie_poster.jpg",
      date: "10/06/2026",
      price: 150.0,
      seats: Seat(seathorizontalamount: 10, seatvertivalamount: 20),
    ),
    Concert(
      id: 5,
      name: "Weekends with Adele",
      imagelink: "https://upload.wikimedia.org/wikipedia/en/6/63/Weekends_with_Adele_poster.png",
      date: "14/07/2026",
      price: 2000.0,
      seats: Seat(seathorizontalamount: 10, seatvertivalamount: 10),
    ),
    Concert(
      id: 6,
      name: "Mathematics Tour - Ed Sheeran",
      imagelink: "https://upload.wikimedia.org/wikipedia/en/2/2c/Mathematics_Tour.png",
      date: "22/08/2026",
      price: 600.0,
      seats: Seat(seathorizontalamount: 30, seatvertivalamount: 30),
    ),
    Concert(
      id: 7,
      name: "Chan Troi Ruc Ro - Ha Anh Tuan",
      imagelink: "https://i.scdn.co/image/ab67616d0000b27376c9e03666d9972357fb464a",
      date: "02/09/2026",
      price: 200.0,
      seats: Seat(seathorizontalamount: 12, seatvertivalamount: 15),
    ),
    Concert(
      id: 8,
      name: "Mercury World Tour",
      imagelink: "https://upload.wikimedia.org/wikipedia/en/b/b3/Mercury_World_Tour_poster.jpg",
      date: "11/10/2026",
      price: 550.0,
      seats: Seat(seathorizontalamount: 18, seatvertivalamount: 18),
    ),
  ];

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