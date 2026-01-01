import 'package:flutter/material.dart';
import 'package:concertbooker/Concert.dart';
import 'package:concertbooker/Seat.dart';

class AppState extends ChangeNotifier {
  bool isAdminMode = false;

  List<Concert> concerts = [];

  AppState() {
    _loadSampleData();
  }

  void _loadSampleData() {
    concerts.add(Concert(
      id: 1,
      name: "BLACKPINK World Tour 2026",
      imagelink: "https://ticketbox.vn/_next/image?url=https%3A%2F%2Fstatic.ticketbox.vn%2Fpublic%2Fimages%2F2024%2F12%2F12%2Fblackpink-world-tour-2025-born-pink-in-cinemas-vietnam-1733991078.jpg&w=1080&q=75",
      seats: Seat(seathorizontalamount: 10, seatvertivalamount: 8),
    ));

    concerts.add(Concert(
      id: 2,
      name: "Ed Sheeran Mathematics Tour",
      imagelink: "https://billboard.vn/wp-content/uploads/2024/11/ed-sheeran-vietnam-2025-1024x1024.jpg",
      seats: Seat(seathorizontalamount: 8, seatvertivalamount: 10),
    ));

    concerts.add(Concert(
      id: 3,
      name: "Concert Sơn Tùng M-TP",
      imagelink: "https://media-cdn-v2.laodong.vn/storage/newsportal/2024/8/26/1391488/Son-Tung-M-TP.jpg",
      seats: Seat(seathorizontalamount: 12, seatvertivalamount: 6),
    ));
  }

  void toggleAdminMode() {
    isAdminMode = !isAdminMode;
    notifyListeners();
  }

  void addConcert(String name, String imageLink, int rows, int columns) {
    final newSeat = Seat(seathorizontalamount: rows, seatvertivalamount: columns);
    final newConcert = Concert(
      id: concerts.isEmpty ? 1 : concerts.last.id + 1,
      name: name,
      imagelink: imageLink,
      seats: newSeat,
    );
    concerts.add(newConcert);
    notifyListeners();
  }

  void bookSeats(int concertId, List<List<int>> updatedSeatArray) {
    final concert = concerts.firstWhere((c) => c.id == concertId);
    concert.seats.seatarray = updatedSeatArray;
    notifyListeners();
  }
}