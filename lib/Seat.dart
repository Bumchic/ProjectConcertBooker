class Seat {
  int seatvertivalamount = 0;
  int seathorizontalamount = 0;

  Seat({required this.seathorizontalamount, required this.seatvertivalamount});
  int GetSeatAmount()
  {
    return seatvertivalamount * seathorizontalamount;
  }
}