import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final Function(SwipeDirection) onSwipe;
  final Widget child;

  const SwipeDetector(
      {super.key,
      required this.onSwipe,
      required this.child,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
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
      child: child,
    );
  }
}

enum SwipeDirection { up, down, left, right }
