import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final Function(SwipeDirection) onSwipe;
  final Widget child;
  final Color currentColor; 
  final String currentMove; 

  const SwipeDetector({
    Key? key,
    required this.onSwipe,
    required this.child,
    required this.currentColor,
    required this.currentMove
  }) : super(key: key);

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
      child: Container(
        width: 200,
        height: 200,
        color: currentColor,
        child: Center(
          child: Text(currentMove),
        ),
      ),
    );
  }
}

enum SwipeDirection { up, down, left, right }

