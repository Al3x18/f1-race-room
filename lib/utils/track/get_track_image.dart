import 'package:flutter/material.dart';

Image getTrackImage(String circuitName) {
  //Track Name Should be without Accents and Special Characters
  final Map<String, String> circuitImages = {
    'Bahrain International Circuit': 'assets/f1Tracks/Bahrain_Circuit.png',
    'Jeddah Corniche Circuit': 'assets/f1Tracks/Saudi_Arabia_Circuit.png',
    'Albert Park Grand Prix Circuit': 'assets/f1Tracks/Australia_Circuit.png',
    'Suzuka Circuit': 'assets/f1Tracks/Japan_Circuit.png',
    'Shanghai International Circuit': 'assets/f1Tracks/China_Circuit.png',
    'Miami International Autodrome': 'assets/f1Tracks/Miami_Circuit.png',
    'Autodromo Enzo e Dino Ferrari': 'assets/f1Tracks/Emilia_Romagna_Circuit.png',
    'Circuit de Monaco': 'assets/f1Tracks/Monaco_Circuit.png',
    'Circuit Gilles Villeneuve': 'assets/f1Tracks/Canada_Circuit.png',
    'Circuit de Barcelona-Catalunya': 'assets/f1Tracks/Spain_Circuit.png',
    'Red Bull Ring': 'assets/f1Tracks/Austria_Circuit.png',
    'Silverstone Circuit': 'assets/f1Tracks/Great_Britain_Circuit.png',
    'Hungaroring': 'assets/f1Tracks/Hungary_Circuit.png',
    'Circuit de Spa-Francorchamps': 'assets/f1Tracks/Belgium_Circuit.png',
    'Circuit Park Zandvoort': 'assets/f1Tracks/Netherlands_Circuit.png',
    'Autodromo Nazionale di Monza': 'assets/f1Tracks/Italy_Circuit.png',
    'Baku City Circuit': 'assets/f1Tracks/Baku_Circuit.png',
    'Marina Bay Street Circuit': 'assets/f1Tracks/Singapore_Circuit.png',
    'Circuit of the Americas': 'assets/f1Tracks/USA_Circuit.png',
    'Autodromo Hermanos Rodriguez': 'assets/f1Tracks/Mexico_Circuit.png',
    'Autodromo Jose Carlos Pace': 'assets/f1Tracks/Brazil_Circuit.png',
    'Las Vegas Strip Street Circuit': 'assets/f1Tracks/Las_Vegas_Circuit.png',
    'Losail International Circuit': 'assets/f1Tracks/Qatar_Circuit.png',
    'Yas Marina Circuit': 'assets/f1Tracks/Abu_Dhabi_Circuit.png',
    'Sochi Autodrom': 'assets/f1Tracks/Russia_Circuit.png',
    'Sepang International Circuit': 'assets/f1Tracks/Sepang_Circuit.png',
    'Autodromo Internazionale del Mugello': 'assets/f1Tracks/Tuscany_Circuit.png',
    'Autodromo Internacional do Algarve': 'assets/f1Tracks/Portugal_Circuit.png',
    'Nurburgring': 'assets/f1Tracks/Nurburgring_Circuit.png',
    'Istanbul Park': 'assets/f1Tracks/Turkey_Circuit.png',
    'Hockenheimring': 'assets/f1Tracks/Germany_Circuit_Hockenheim.png',
    'Fuji Speedway': 'assets/f1Tracks/Fuji_Circuit.png',
    'Valencia Street Circuit': 'assets/f1Tracks/Valencia_Circuit.png',
    'Korean International Circuit': 'assets/f1Tracks/Korea_Circuit.png',
    'Buddh International Circuit': 'assets/f1Tracks/India_Circuit.png',
  };

  String? imagePath = circuitImages[_removeAccentsAndSpecialCharacters(circuitName)];
  
  return imagePath != null
      ? Image.asset(imagePath)
      : Image.asset('assets/images/track_error_w.png');
}

String _removeAccentsAndSpecialCharacters(String input) {
  const Map<String, String> accentsMap = {
    'á': 'a', 'à': 'a', 'ä': 'a', 'â': 'a', 'ã': 'a',
    'é': 'e', 'è': 'e', 'ë': 'e', 'ê': 'e',
    'í': 'i', 'ì': 'i', 'ï': 'i', 'î': 'i',
    'ó': 'o', 'ò': 'o', 'ö': 'o', 'ô': 'o', 'õ': 'o',
    'ú': 'u', 'ù': 'u', 'ü': 'u', 'û': 'u',
    'ç': 'c', 'ñ': 'n',
  };

  accentsMap.forEach((accentedChar, replacementChar) {
    input = input.replaceAll(accentedChar, replacementChar);
  });

  //input = input.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '');

  input = input.replaceAll(RegExp(r'\s+'), ' ').trim();

  return input;
}