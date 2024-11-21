import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime raceDate;

  const CountdownTimer({super.key, required this.raceDate});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    setState(() {
      _remainingTime = widget.raceDate.difference(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    final days = _remainingTime.inDays;
    final hours = _remainingTime.inHours.remainder(24);
    final minutes = _remainingTime.inMinutes.remainder(60);

    if (_remainingTime.isNegative) {
      return Text(
        "Race Ended",
        style: listTileStyle.copyWith(color: Colors.green, fontSize: 10.5, fontWeight: FontWeight.bold),
      );
    }

    return Row(
      children: [
        Text(
          "Lights Out In -",
          style: listTileStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 10.5),
        ),
        const SizedBox(width: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "$days days, $hours hours, $minutes minutes",
            style: listTileStyle.copyWith(color: const Color.fromARGB(255, 79, 70, 255), fontSize: 10.5, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
