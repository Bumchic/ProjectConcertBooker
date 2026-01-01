import 'package:flutter/material.dart';

class SeatGrid extends StatelessWidget {
  final int rows;
  final int cols;
  final List<List<int>> seatStatusArray;
  final Set<String> selectedSeats;
  final Function(String seatId) onSeatToggle;

  const SeatGrid({
    super.key,
    required this.rows,
    required this.cols,
    required this.seatStatusArray,
    required this.selectedSeats,
    required this.onSeatToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: cols / rows,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                childAspectRatio: 1.0,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                final int currentRow = index ~/ cols;
                final int currentCol = index % cols;
                final String seatId = "$currentRow-$currentCol";

                // Logic kiểm tra DB (1 = Available, còn lại là Booked)
                bool isAvailableInDB = false;
                if (currentRow < seatStatusArray.length &&
                    currentCol < seatStatusArray[currentRow].length) {
                  isAvailableInDB = seatStatusArray[currentRow][currentCol] == 1;
                }

                final bool isBooked = !isAvailableInDB;
                final bool isSelected = selectedSeats.contains(seatId);

                return GestureDetector(
                  onTap: isBooked ? null : () => onSeatToggle(seatId),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isBooked
                          ? Colors.red[100]
                          : isSelected
                          ? Colors.deepPurple
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                      border: isSelected ? Border.all(color: Colors.deepPurpleAccent, width: 2) : null,
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        "${String.fromCharCode(65 + currentRow)}${currentCol + 1}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}