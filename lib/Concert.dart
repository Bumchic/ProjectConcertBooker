import 'package:concertbooker/Seat.dart';

class Concert{
  int id;
  String name;
  DateTime date;
  String description;
  String imagelink;
  Seat seats;

  Concert({required this.id, required this.name, required this.date
    ,required this.description, required this.imagelink, required this.seats});

}