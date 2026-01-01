import 'package:concertbooker/Concert.dart';
import 'package:flutter/material.dart';

class Concertdetail extends StatefulWidget {
  final Concert concert;

  const Concertdetail({super.key, required this.concert});

  @override
  State<Concertdetail> createState() => ConcertdetailState();
}

class ConcertdetailState extends State<Concertdetail> {
  late Concert concert;

  @override
  void initState() {
    super.initState();
    concert = widget.concert;
    print(concert.seats.seatarray);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Concert Detail"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardBuilder(
              Image.network(
                concert.imagelink,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            CardBuilder(
              Text(
                concert.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            CardBuilder(
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text("Date: ${concert.date}"),
                ],
              ),
            ),

            CardBuilder(
              Row(
                children: [
                  const Icon(Icons.attach_money, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text("Price: \$${concert.price.toStringAsFixed(2)}"),
                ],
              ),
            ),

            CardBuilder(
              Row(
                children: [
                  const Icon(Icons.event_seat, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text("Total seats: ${concert.seats.Totalseat}"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🛒 Order Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order Seat - Coming soon")),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Order Seat"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CardBuilder(Widget content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: content,
      ),
    );
  }
}
