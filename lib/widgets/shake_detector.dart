import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async'; // for stream subscription
//import 'package:flutter/services.dart';

class ShakeDetector extends StatefulWidget {
  final Function() onShake;

  const ShakeDetector({super.key, required this.onShake});

  @override
  _ShakeDetectorState createState() => _ShakeDetectorState();
}

class _ShakeDetectorState extends State<ShakeDetector> {
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  DateTime? _lastShakeTime;
  static const _shakeThreshold = 15;
  static const _shakeCooldown = Duration(milliseconds: 500);
  UserAccelerometerEvent? _userAccelerometerEvent;
  Duration sensorInterval = SensorInterval.normalInterval;
  DateTime? _userAccelerometerUpdateTime;
  int? _userAccelerometerLastInterval;


@override
void initState() {
    super.initState();
     _streamSubscriptions.add(
      userAccelerometerEventStream(samplingPeriod: sensorInterval).listen(
        (UserAccelerometerEvent event) {
          final totalAcceleration = event.x.abs() + event.y.abs() + event.z.abs();
          final now = DateTime.now();
          setState(() {
            _userAccelerometerEvent = event;

            // if (_userAccelerometerUpdateTime != null) {
            //   final interval = now.difference(_userAccelerometerUpdateTime!);
            //   if (interval > _ignoreDuration) {
            //     _userAccelerometerLastInterval = interval.inMilliseconds;
            //   }
            // }
                        if (totalAcceleration > _shakeThreshold &&
            (_lastShakeTime == null || now.difference(_lastShakeTime!) > _shakeCooldown)) {
          _lastShakeTime = now;
          widget.onShake();
        }
          });
          _userAccelerometerUpdateTime = now;
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support User Accelerometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
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

