import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Concertdetail extends StatefulWidget
{
    @override
  State<StatefulWidget> createState() {
    return ConcertdetailState();
  }
}

class ConcertdetailState extends State<Concertdetail>
{
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
              child: CardBuilder(Center(child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdY14nLrQ4WENI0mMI5PmvQQYGAIkw-yDl9A&s"),)),
            ),
            Container(
              width: double.infinity,
              child: CardBuilder(Center(child: Text("Concert name"))),
            ),
            Container(
              width: double.infinity,
              child: CardBuilder(Center(child: Text("seat amount"))),
            )
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
