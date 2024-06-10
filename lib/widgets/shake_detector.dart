import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector extends StatefulWidget {
  final Function() onShake;

  const ShakeDetector({Key? key, required this.onShake}) : super(key: key);

  @override
  _ShakeDetectorState createState() => _ShakeDetectorState();
}

class _ShakeDetectorState extends State<ShakeDetector> {
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  DateTime? _lastShakeTime;
  static const shakeThreshold = 15;
  static const shakeCooldown = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen((AccelerometerEvent event) {
        final totalAcceleration = event.x.abs() + event.y.abs() + event.z.abs();
        final currentTime = DateTime.now();

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
    return Container(); // Empty container, to overlay on top of the shakedetector container 
  }
}
