import 'package:flutter/material.dart';
import 'package:race_room/utils/medal_colors.dart';

enum PositionContainerType { driverAndConstructorView, driversAfterRace }

class BuildPositionContainer extends StatelessWidget {
  const BuildPositionContainer({
    super.key,
    required this.type,
    required this.position,
    this.fontSizeDriverAndConstructor = 15.2,
    this.fontSizeDriversAfterRace = 14.2,
  });

  final PositionContainerType type;
  final String position;
  final double fontSizeDriverAndConstructor;
  final double fontSizeDriversAfterRace;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    if (type == PositionContainerType.driverAndConstructorView) {
      return Container(
        decoration: BoxDecoration(
          color: position == "1" ? const Color.fromARGB(255, 49, 56, 255) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Text(
              position == "ND" ? "ND" 
              : position == "No Data" ? "ND"
              : "#$position",
              style: listTileStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeDriverAndConstructor,
                color: position == "1" ? Colors.white : const Color.fromARGB(255, 106, 106, 106),
              ),
            ),
          ),
        ),
      );
    } else if (type == PositionContainerType.driversAfterRace) {
      return Container(
        decoration: BoxDecoration(
          color: position == "1"
              ? MedalColors.gold
              : position == "2"
                  ? MedalColors.silver
                  : position == "3"
                      ? MedalColors.lightBronze
                      : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            "P$position",
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: fontSizeDriversAfterRace, 
              color: isDark 
              ? position == "1" 
              || position == "2"
              || position == "3"
              ? Colors.black 
              : Colors.white
              : const Color.fromARGB(255, 74, 74, 74),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
