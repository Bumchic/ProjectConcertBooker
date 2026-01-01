import 'package:flutter/material.dart';

class BookingBottomBar extends StatelessWidget {
  final int selectedCount;
  final double pricePerSeat;
  final VoidCallback onBuyPressed;

  const BookingBottomBar({
    super.key,
    required this.selectedCount,
    required this.pricePerSeat,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double totalPrice = selectedCount * pricePerSeat;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$selectedCount seats selected",
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: selectedCount == 0 ? null : onBuyPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("BUY NOW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}