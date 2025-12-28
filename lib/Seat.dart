class Seat {
  int seatvertivalamount = 0;
  int seathorizontalamount = 0;
  get Totalseat
  {
    return seatvertivalamount * seathorizontalamount;
  }
  List<List<int>> seatarray;

  Seat({required this.seathorizontalamount, required this.seatvertivalamount})
      :seatarray = List.generate(seathorizontalamount, (i) => List.generate(seatvertivalamount, (j) => 1));




}