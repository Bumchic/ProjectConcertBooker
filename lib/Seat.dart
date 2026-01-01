class Seat {
  int seatvertivalamount = 0;
  int seathorizontalamount = 0;
  get Totalseat
  {
    return seatvertivalamount * seathorizontalamount;
  }
  List<List<int>> seatarray;

  Seat.Default({this.seathorizontalamount = 20, this.seatvertivalamount = 20})
      :seatarray = List.generate(seatvertivalamount, (i) => List.generate(seathorizontalamount, (j) => 1));

  Seat({required this.seathorizontalamount, required this.seatvertivalamount, required this.seatarray});




}