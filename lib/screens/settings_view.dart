import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextStyle devByStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 9.2,
    color: Colors.grey.shade400,
  );

  String? selectedTheme = "Wait...";
  String version = "Unknown";
  String buildNumber = "Unknown";

  String devMail = "smith@example.com";
  String initialSubject = "Report dated: ${DateTime.now().toString()}";

  @override
  void initState() {
    super.initState();
    _getAppInfo();
    _getThemePrefs();
  }

  void _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    setState(() {});
  }

  void _getThemePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTheme = prefs.getString('theme') ?? 'light';
    });
  }

  void _setThemePrefs(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  void _selectTheme(String theme) {
    setState(() {
      selectedTheme = theme;
    });
  }

  void _sendEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: devMail,
      query: encodeQueryParameters(<String, String>{
        'subject': initialSubject,
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Developed by:", style: devByStyle),
            Text("Alex De Pasquale", style: devByStyle),
          ],
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("App Version"),
          trailing: Text(
            version,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text("Build: $buildNumber", style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ),
        ListTile(
          leading: const Icon(Icons.mail_outline),
          title: const Text("Report an Issue"),
          subtitle: const Text(
            "or request new feature",
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _sendEmail(),
        ),
        ExpansionTile(
          title: const Text("Theme Mode"),
          leading: const Icon(Icons.display_settings_outlined),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selectedTheme!, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
              const SizedBox(width: 10),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode_outlined),
              title: const Text("Light"),
              trailing: selectedTheme == "Light" ? const Icon(Icons.check, color: Colors.red) : null,
              onTap: () {
                _selectTheme("Light");
                _setThemePrefs("Light");
                Get.changeThemeMode(ThemeMode.light);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text("System"),
              trailing: selectedTheme == "System" ? const Icon(Icons.check, color: Colors.red) : null,
              onTap: () {
                _selectTheme("System");
                _setThemePrefs("System");
                Get.changeThemeMode(ThemeMode.system);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text("Dark"),
              trailing: selectedTheme == "Dark" ? const Icon(Icons.check, color: Colors.red) : null,
              onTap: () {
                _selectTheme("Dark");
                _setThemePrefs("Dark");
                Get.changeThemeMode(ThemeMode.dark);
              },
            ),
          ],
        ),
      ],
    );
  }
}
