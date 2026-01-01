import 'package:concertbooker/Concert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Concertdetail extends StatefulWidget
{
  Concert concert;
  Concertdetail({required this.concert});
    @override
  State<StatefulWidget> createState() {
    return ConcertdetailState(concert: concert);
  }
}

class ConcertdetailState extends State<Concertdetail>
{
  Concert concert;
  ConcertdetailState({required this.concert});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Concert detail"),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: CardBuilder(Center(child: Image.network(concert.imagelink),)),
            ),
            Container(
              width: double.infinity,
              child: CardBuilder(Center(child: Text("Name: " + concert.name))),
            ),
            Container(
              width: double.infinity,
              child: CardBuilder(Center(child: Text("Seat amount: " + concert.seats.Totalseat.toString()))),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Order Seat"),
            ),
          ],
        ),
      ),
    );
  }

  Widget CardBuilder(Widget content)
  {
    return Card(
      child: content,
      shadowColor: Colors.green,
      surfaceTintColor: Colors.blue,
    );
  }
}
