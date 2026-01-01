class Seat {
  int seatvertivalamount = 0;
  int seathorizontalamount = 0;
  get Totalseat
  {
    return seatvertivalamount * seathorizontalamount;
  }
  List<List<int>> seatarray;

  Seat({this.seathorizontalamount = 20, this.seatvertivalamount = 20})
      :seatarray = List.generate(seathorizontalamount, (i) => List.generate(seatvertivalamount, (j) => 1));




}