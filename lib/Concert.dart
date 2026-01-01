import 'Seat.dart';

class Concert {
  final int id;
  final String name;
  final String date;
  final double price;
  final String imagelink;
  final Seat seats;

  Concert({
    this.id = -1,
    required this.name,
    required this.date,
    required this.price,
    required this.imagelink,
    required this.seats,
  });
  Map<String, dynamic> ToMap()
  {
    return {
      "name": name,
      "date": date,
      "price" : price,
      "imagelink": imagelink
    };
  }
}