import 'dart:async';
import 'package:flutter/material.dart';
import 'package:race_room/utils/app_colors.dart';

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

    // F1 first race date 1950-05-13 is used ad dummy value to not show countdown timer if race time is not available
    if (widget.raceDate.isAtSameMomentAs(DateTime(1950, 5, 13))) {
      return SizedBox.shrink();
    }

    if (_remainingTime.isNegative) {
      // If more than 2 hours have passed since the race date then the race has probably ended
      if (_remainingTime.inHours < -2) {
        return Text(
          "Race Ended",
          style: listTileStyle.copyWith(color: AppColors.countdownTimerRaceEnded, fontSize: 10.5, fontWeight: FontWeight.bold),
        );
      }

      // if less than 2 hours have passed since the race date and time then the race is still ongoing
      return Text(
        "Race Ongoing...",
        style: listTileStyle.copyWith(color: AppColors.countdownTimerRaceOngoing, fontSize: 10.5, fontWeight: FontWeight.bold),
      );
    }

    return Row(
      children: [
        Text(
          "Lights Out In -",
          style: listTileStyle.copyWith(fontWeight: FontWeight.bold, color: AppColors.countdownLightsOutText, fontSize: 10.5),
        ),
        const SizedBox(width: 4),
        Flexible(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "$days days, $hours hours, $minutes minutes",
              style: listTileStyle.copyWith(color: AppColors.countdownTimerText, fontSize: 10.5, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
