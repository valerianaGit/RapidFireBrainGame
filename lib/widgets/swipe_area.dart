// File: swipe_area.dart
import 'package:flutter/material.dart';
import 'swipe_detector.dart';

class SwipeArea extends StatelessWidget {
  final Function(SwipeDirection) onSwipe;
  final Color currentColor;
  final String currentMove;

  const SwipeArea({
    Key? key,
    required this.onSwipe,
    required this.currentColor,
    required this.currentMove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipe: onSwipe,
      currentColor: currentColor,
      currentMove: currentMove,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: currentColor,
          border: Border.all(color: Colors.black), // Optional border
        ),
        child: Center(
          child: Text(
            currentMove,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
