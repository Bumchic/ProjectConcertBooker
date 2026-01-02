import 'package:flutter/material.dart';
import 'ConcertDetail.dart';

class UserHome extends StatelessWidget {
  final List concerts;
  const UserHome({super.key, required this.concerts});

  @override
  Widget build(BuildContext context) {
    if (concerts.isEmpty) {
      return const Center(child: Text('No concerts available'));
    }

    return ListView.builder(
      itemCount: concerts.length,
      itemBuilder: (context, index) {
        final concert = concerts[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Image.network(
              concert.imagelink,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image),
            ),
            title: Text(concert.name),
            subtitle: Text(concert.date),
            trailing: Text(
              '\$${concert.price}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Concertdetail(concert: concert),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
