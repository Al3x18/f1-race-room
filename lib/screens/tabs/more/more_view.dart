import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_room/screens/tabs/more/more_screens/news_view.dart';
import 'package:race_room/screens/tabs/more/more_screens/settings_view.dart';
import 'package:race_room/screens/tabs/more/more_screens/telemetry/telemetry_request_view.dart';
import 'package:race_room/utils/colors/app_colors.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        spacing: 2,
        children: [
          _buildMoreViewListTile(
            title: "NEWS",
            subtitle: "latest news about Formula 1",
            leadingIcon: const Icon(Icons.newspaper),
            onTap: () => Get.to(
              () => const NewsView(),
            ),
          ),
          _buildMoreViewListTile(
            title: "TELEMETRY",
            subtitle: "open telemetry data section",
            leadingIcon: Image.asset(isDark ? "assets/images/telemetry-icon-dark.png" : "assets/images/telemetry-icon.png", width: 21),
            onTap: () => Get.to(
              () => const TelemetryRequestView(appBarType: AppBarType.moreMenu, betaMode: BetaMode.on),
            ),
          ),
          _buildMoreViewListTile(
            title: "SETTINGS",
            subtitle: "open app settings",
            leadingIcon: const Icon(Icons.settings),
            onTap: () => Get.to(
              () => const SettingsView(),
            ),
          ),
        ],
      ),
    );
  }
}

ListTile _buildMoreViewListTile({
  required String title,
  required Widget leadingIcon,
  required VoidCallback onTap,
  String? subtitle,
}) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    ),
    subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: AppColors.moreViewSubtitle, fontSize: 11.5)) : null,
    leading: leadingIcon,
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}
