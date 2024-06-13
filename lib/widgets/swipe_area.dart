// File: swipe_area.dart
import 'package:flutter/material.dart';
import 'swipe_detector.dart';

class SwipeArea extends StatelessWidget {
  final Function(SwipeDirection) onSwipe;
  final Color currentColor;
  final String currentMove;

  const SwipeArea({
    super.key,
    required this.onSwipe,
    required this.currentColor,
    required this.currentMove,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipe: onSwipe,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: currentColor,
          border: Border.all(color: Colors.black), 
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
