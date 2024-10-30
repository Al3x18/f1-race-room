import 'package:flutter/material.dart';

Map<String, Color> f1TeamColors = {
  "Red Bull": const Color(0xFF1E41FF),
  "Ferrari": const Color(0xFFDC0000),
  "Mercedes": const Color(0xFFA3A3A3),
  "McLaren": const Color(0xFFFF8700),
  "Alpine F1 Team": const Color(0xFF0090FF),
  "Aston Martin": const Color(0xFF2D826D),
  "RB F1 Team": const Color(0xFF4E7C9B),
  "Sauber": const Color.fromARGB(255, 45, 203, 1),
  "Haas F1 Team": const Color.fromARGB(255, 120, 42, 42),
  "Williams": const Color(0xFF005AFF),
};

Color getTeamColor(String teamName) {
  return f1TeamColors[teamName] ?? Colors.black;
}