class Seat {
  int seatvertivalamount = 0;
  int seathorizontalamount = 0;
  List<List<int>> seats;
  Seat({required this.seathorizontalamount, required this.seatvertivalamount})
  {
    seats = List.generate(seathorizontalamount, (i) => List.generate(seatvertivalamount, (j) => 1));
  }
  int GetSeatAmount()
  {
    return seatvertivalamount * seathorizontalamount;
  }
}