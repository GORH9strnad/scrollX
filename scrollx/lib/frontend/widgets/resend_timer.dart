import 'dart:async';
import 'package:flutter/material.dart';

class ResendTimer extends StatefulWidget {
  const ResendTimer({Key? key}) : super(key: key);

  @override
  State<ResendTimer> createState() => _ResendCounterState();
}

class _ResendCounterState extends State<ResendTimer> {
  bool _timerActive = false;
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    _timerActive = true;
    _start = 30;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 1) {
        setState(() {
          _timer?.cancel();
          _timerActive = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timerActive) {
      return Text(
        'Next resend in $_start',
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            startTimer();
          });
        },
        child: Text(
          'Resend code',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.blue
          ),
        ),
      );
    }
  }
}