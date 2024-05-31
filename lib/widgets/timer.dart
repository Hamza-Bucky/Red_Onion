import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tunnel/main.dart';

class timer extends StatefulWidget {
  final bool startTimer;
  const timer({super.key, required this.startTimer});

  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {
  Duration duration = Duration();
  Timer? _timer;
//FUNTION TO INCREMENT TIMER
  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    });
  }

  _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
      duration = Duration();
    });
  }

  @override
  //SETTING UP MY TIMER FOR  VPN CONNECTION
  Widget build(BuildContext context) {
    if (_timer == null || !widget.startTimer) {
      widget.startTimer ? _startTimer() : _stopTimer();
    }

    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigit(duration.inSeconds.remainder(60));
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final hours = twoDigit(duration.inHours.remainder(60));

    return Text(
      "$hours:$minutes:$seconds",
      style: TextStyle(
          fontSize: 25,
          color: Theme.of(context).LightText,
          fontFamily: 'poppin'),
    );
  }
}
