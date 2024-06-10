import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final Function(SwipeDirection) onSwipe; // Callback function for swipe events

  const SwipeDetector({super.key, required this.onSwipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Check if the swipe is significant enough
        if (details.delta.dx.abs() > 30 || details.delta.dy.abs() > 30) {
          if (details.delta.dx > 0) {
            onSwipe(SwipeDirection.right);
          } else if (details.delta.dx < 0) {
            onSwipe(SwipeDirection.left);
          } else if (details.delta.dy > 0) {
            onSwipe(SwipeDirection.down);
          } else if (details.delta.dy < 0) {
            onSwipe(SwipeDirection.up);
          }
        }
      },
      child: Container(
        // Your widget's content goes here (e.g., an icon or text)
      ),
    );
  }
}

enum SwipeDirection { up, down, left, right }
