import 'package:flutter/material.dart';
import '../../ConcertDetail.dart';

class ConcertSearchDelegate extends SearchDelegate {
  final List concerts;
  ConcertSearchDelegate({required this.concerts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = concerts.where((c) =>
        c.name.toLowerCase().contains(query.toLowerCase())).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No results'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final concert = results[index];
        return ListTile(
          title: Text(concert.name),
          subtitle: Text(concert.date),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Concertdetail(concert: concert),
              ),
            );
          },
        );
      },
    );
  }
}
