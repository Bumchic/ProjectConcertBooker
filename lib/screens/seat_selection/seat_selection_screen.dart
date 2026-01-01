import 'package:flutter/material.dart';
import 'package:concertbooker/Concert.dart';
// Import các widget con vừa tạo
import 'package:concertbooker/screens/seat_selection/widgets/stage_indicator.dart';
import 'widgets/seat_legend.dart';
import 'widgets/seat_grid.dart';
import 'widgets/booking_bottom_bar.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Concert concert;

  const SeatSelectionScreen({super.key, required this.concert});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final Set<String> _selectedSeats = {};

  void _handleSeatToggle(String seatId) {
    setState(() {
      if (_selectedSeats.contains(seatId)) {
        _selectedSeats.remove(seatId);
      } else {
        _selectedSeats.add(seatId);
      }
    });
  }

  void _handleBuyNow() {
    // Xử lý logic mua vé tại đây (gọi Database)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Processing ${_selectedSeats.length} seats...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int rows = widget.concert.seats.seathorizontalamount;
    final int cols = widget.concert.seats.seatvertivalamount;
    final List<List<int>> seatStatusArray = widget.concert.seats.seatarray;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.concert.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 1. Sân khấu
          const StageIndicator(),

          // 2. Chú thích
          const SeatLegend(),

          const Divider(height: 30),

          // 3. Lưới ghế (Truyền state và callback vào)
          Expanded(
            child: SeatGrid(
              rows: rows,
              cols: cols,
              seatStatusArray: seatStatusArray,
              selectedSeats: _selectedSeats,
              onSeatToggle: _handleSeatToggle,
            ),
          ),

          // 4. Thanh thanh toán
          BookingBottomBar(
            selectedCount: _selectedSeats.length,
            pricePerSeat: widget.concert.price,
            onBuyPressed: _handleBuyNow,
          ),
        ],
      ),
    );
  }
}