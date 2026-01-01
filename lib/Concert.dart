import 'Seat.dart';

class Concert {
  final int id;
  final String name;
  final String date;
  final double price;
  final String imagelink; // Lưu ý: trong code bạn gửi là imagelink (chữ l thường)
  final Seat seats;
   // Mới thêm

  Concert({
    required this.id,
    required this.name,
    required this.date,
    required this.price,
    required this.imagelink,
    required this.seats,
  });
  Map<String, dynamic> ToMap()
  {
    return {
      "id" : this.id,
      "name": name,
      "date": date,
      "price" : price,
      "imagelink": imagelink
    };
  }
}