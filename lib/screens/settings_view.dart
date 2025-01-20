import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:race_room/utils/not_share.dart';
import 'package:race_room/utils/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextStyle _devByStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 9.2,
    color: Colors.grey.shade400,
  );

  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 14.4,
  );

  Color _devNameColor = Colors.grey.shade400;

  String version = "Unknown";
  String buildNumber = "Unknown";

  final String devMail = REPORT_BUG_EMAIL;
  final String devName = DEV_NAME;
  final String initialSubject = "Race Room, report dated: ${DateTime.now().toString()}";

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  void initState() {
    super.initState();
    _getAppInfo();
  }

  void _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
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

  void _openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    );
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    
    final TextStyle devLabelStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 10,
      color: _devNameColor,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Text("Developed by:", style: _devByStyle),
              GestureDetector(
                onTapDown: (_) {
                  _devNameColor = Colors.grey.shade300;
                  setState(() {});
                }, 
                onTapUp: (_) {
                  _devNameColor = Colors.grey.shade400;
                  setState(() {});
                  _openUrl(DEV_GITHUB);
                },
                child: Text(devName, style: devLabelStyle),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text("App Version", style: titleTextStyle),
            trailing: Text(
              version,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Text("Build number: $buildNumber", style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: Text("Report an Issue", style: titleTextStyle),
            subtitle: const Text(
              "or request new feature",
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _sendEmail(),
          ),
          ExpansionTile(
            title: Text("Theme Mode", style: titleTextStyle),
            subtitle: Obx(() {
              return Row(
                children: [
                  const Text("Current mode: ", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  Text(
                    settingsController.currentTheme.value == ThemeMode.light
                        ? "Light"
                        : settingsController.currentTheme.value == ThemeMode.dark
                            ? "Dark"
                            : "System",
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              );
            }),
            leading: const Icon(Icons.display_settings_outlined),
            children: [
              Obx(() {
                return ListTile(
                  leading: const Icon(Icons.light_mode_outlined),
                  title: Text("Light", style: titleTextStyle),
                  onTap: () {
                    settingsController.setTheme("Light");
                  },
                  trailing: settingsController.currentTheme.value == ThemeMode.light ? const Icon(Icons.check) : null,
                );
              }),
              Obx(() {
                return ListTile(
                  leading: const Icon(Icons.sync),
                  title: Text("System", style: titleTextStyle),
                  onTap: () {
                    settingsController.setTheme("System");
                  },
                  trailing: settingsController.currentTheme.value == ThemeMode.system ? const Icon(Icons.check) : null,
                );
              }),
              Obx(() {
                return ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: Text("Dark", style: titleTextStyle),
                  onTap: () {
                    settingsController.setTheme("Dark");
                  },
                  trailing: settingsController.currentTheme.value == ThemeMode.dark ? const Icon(Icons.check) : null,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
