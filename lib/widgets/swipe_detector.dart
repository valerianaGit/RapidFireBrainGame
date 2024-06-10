import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SwipeDetector extends StatefulWidget {
  final Function(SwipeDirection) onSwipe; // Callback function for swipe events

    final Function() onShake;
  final Color currentColor; // Add currentColor property
  final String currentMove; // Add currentMove property

  const SwipeDetector({
    Key? key,
    required this.onSwipe,
    required this.onShake,
    required this.currentColor, // Require currentColor
    required this.currentMove, // Require currentMove
  }) : super(key: key);

  @override
  State<SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
    final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  DateTime? _lastShakeTime;
  static const shakeThreshold = 15; // Adjust sensitivity
  static const shakeCooldown = Duration(milliseconds: 500);

     @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen((UserAccelerometerEvent event) {
        final totalAcceleration = event.x.abs() + event.y.abs() + event.z.abs();
        final currentTime = DateTime.now();

        // Check if acceleration exceeds threshold and enough time has passed since the last shake
        if (totalAcceleration > shakeThreshold && 
            (_lastShakeTime == null || currentTime.difference(_lastShakeTime!) > shakeCooldown)) {
          _lastShakeTime = currentTime;
          widget.onShake();
        }
      }),
    );
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Check if the swipe is significant enough
        if (details.delta.dx.abs() > 30 || details.delta.dy.abs() > 30) {
          if (details.delta.dx > 0) {
            widget.onSwipe(SwipeDirection.right);
          } else if (details.delta.dx < 0) {
            widget.onSwipe(SwipeDirection.left);
          } else if (details.delta.dy > 0) {
            widget.onSwipe(SwipeDirection.down);
          } else if (details.delta.dy < 0) {
            widget.onSwipe(SwipeDirection.up);
          }
        }
      },
      child: Container(
        // Your widget's content goes here (e.g., an icon or text)
                width: 200,
        height: 200,
        color: widget.currentColor, // Use widget.currentColor
        child: Center(
          child: Text(widget.currentMove), 
          ),
      ),
    );
  }
}

enum SwipeDirection { up, down, left, right }
