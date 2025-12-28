import 'package:concertbooker/Seat.dart';

class Concert{
  int id;
  String name;
  String imagelink;
  Seat seats;

  Concert({required this.id, required this.name, required this.imagelink, required this.seats});

}