import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/screens/root_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.light,
      home: const RootView(),
    ),
  );
}

ThemeData _buildLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    fontFamily: "Formula1",
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    fontFamily: "Formula1",
  );
}
