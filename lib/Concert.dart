import 'Seat.dart';

class Concert {
  final int id;
  final String name;
  final DateTime date;
  final String description;
  final double price;
  final String imagelink; // Lưu ý: trong code bạn gửi là imagelink (chữ l thường)
  final Seat seats;
   // Mới thêm

  Concert({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.imagelink,
    required this.seats,
    required this.price,
  });
  Map<String, dynamic> ToMap()
  {
    return {
      "id" : this.id,
      "name": name,
      "date": "${date.year}-${date.month}-${date.day}",
      "description": description,
      "price" : price,
      "imagelink": imagelink
    };
  }
}