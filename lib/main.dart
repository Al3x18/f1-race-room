import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:race_room/utils/colors/app_colors.dart';
import 'package:race_room/utils/controllers/settings_controller.dart';
import 'package:race_room/utils/controllers/tab_text_settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:race_room/screens/root_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SettingsController());
  Get.put(TabTextSettingsController());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final SettingsController settingsController = Get.put(SettingsController());
  final String themePref = await getThemePrefs();

  final ThemeMode themeMode = getThemeMode(themePref);

  settingsController.setTheme(themePref);

  runApp(MyApp(themeMode: themeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeMode});

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final themeMode = Get.find<SettingsController>().currentTheme.value;

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: themeMode,
          home: const RootView(),
        );
      },
    );
  }
}

Future<String> getThemePrefs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('theme') ?? 'Light';
}

ThemeMode getThemeMode(String theme) {
  if (theme == 'Light') {
    return ThemeMode.light;
  } else if (theme == 'Dark') {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}

ThemeData _buildLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.themeLightPrimary,
    fontFamily: "Formula1",
    scaffoldBackgroundColor: AppColors.scaffoldLightBackground,
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.themeDarkPrimary,
    fontFamily: "Formula1",
    scaffoldBackgroundColor: AppColors.scaffoldDarkBackground,
  );
}
