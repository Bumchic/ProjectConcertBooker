import 'Seat.dart';

class Concert {
  final int id;
  final String name;
  final String imagelink; // Lưu ý: trong code bạn gửi là imagelink (chữ l thường)
  final Seat seats;
  final String date;  // Mới thêm
  final double price; // Mới thêm

  Concert({
    required this.id,
    required this.name,
    required this.imagelink,
    required this.seats,
    required this.date,
    required this.price,
  });
}