import 'package:flutter/material.dart';

class StageIndicator extends StatelessWidget {
  const StageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(100)),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: const Text(
        "STAGE",
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.black54),
      ),
    );
  }
}