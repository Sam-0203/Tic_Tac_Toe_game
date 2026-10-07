import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  final String value;

  final VoidCallback onTap;

  final bool isWinningCell;

  const GameCell({
    super.key,
    required this.value,
    required this.onTap,
    required this.isWinningCell,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),

        margin: const EdgeInsets.all(4),

        decoration: BoxDecoration(
          color: isWinningCell ? Colors.green : Colors.blueGrey.shade100,

          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(
              blurRadius: isWinningCell ? 12 : 4,
              color: Colors.black26,
            ),
          ],
        ),

        child: Center(
          child: AnimatedScale(
            scale: value.isNotEmpty ? 1 : 0.5,

            duration: const Duration(milliseconds: 300),

            child: Text(
              value,

              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,

                color: value == 'X' ? Colors.blue : Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
