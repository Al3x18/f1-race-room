import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:race_room/screens/telemetry/telemetry_request_view.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/constructor_standings_model.dart';
import 'package:race_room/model/driver_standings_model.dart';
import 'package:race_room/model/race_schedule_model.dart';
import 'package:race_room/screens/tabs/constructor_standings_view.dart';
import 'package:race_room/screens/tabs/drivers_standings_view.dart';
import 'package:race_room/screens/tabs/races_schedule_view.dart';
import 'package:race_room/screens/select_year/select_year_view.dart';
import 'package:race_room/screens/tabs/settings_view.dart';
import 'package:race_room/utils/colors/app_colors.dart';
import 'package:race_room/utils/controllers/tab_text_settings_controller.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<MRDataDriverStandings?> futureDriverStandingsData;
  late Future<MRDataConstructorStandings?> futureConstructorStandingsData;
  late Future<MRDataRaceSchedule?> futureRaceScheduleData;

  final TabTextSettingsController tabTextSettingsController = Get.find<TabTextSettingsController>();

  String seasonYear = DateTime.now().year.toString();

  int currentPage = 0;
  bool isYearMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentPage = _tabController.index;
      });
    });

    _getAllData();
  }

  void _getAllData() {
    // Get Driver Standings
    futureDriverStandingsData = ApiService().fetchDriverStandings(seasonYear: seasonYear);

    // Get Constructor Standings
    futureConstructorStandingsData = ApiService().fetchConstructorStandings(seasonYear: seasonYear);

    // Get Race Schedule
    futureRaceScheduleData = ApiService().fetchRaceSchedule(seasonYear: seasonYear);

    setState(() {});
  }

  void _getDriverStandingsData() {
    futureDriverStandingsData = ApiService().fetchDriverStandings(seasonYear: seasonYear);
    setState(() {});
  }

  void _getConstructorStandingsData() {
    futureConstructorStandingsData = ApiService().fetchConstructorStandings(seasonYear: seasonYear);
    setState(() {});
  }

  void _getRaceScheduleData() {
    futureRaceScheduleData = ApiService().fetchRaceSchedule(seasonYear: seasonYear);
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double bottomBarBorderRadius = 12;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final TextStyle tabTextStyleFull = TextStyle(
      color: isDarkMode ? AppColors.rootTabTextStyleFullDark : AppColors.rootTabTextStyleFullLight,
      fontWeight: isDarkMode ? FontWeight.w600 : FontWeight.bold,
      fontSize: _calculateTabFontSize(context),
    );

    final TextStyle tabTextStyleShort = TextStyle(
      color: isDarkMode ? AppColors.rootTabTextStyleShortDark : AppColors.rootTabTextStyleShortLight,
      fontWeight: isDarkMode ? FontWeight.w600 : FontWeight.bold,
      fontSize: 18,
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode ? AppColors.rootAppBarGradientDark : AppColors.rootAppBarGradientLight,
            ),
          ),
        ),
        leading: kIsWeb || Platform.isIOS || Platform.isMacOS ? _openTelemetryView(isDarkMode) : null,
        actions: [
          if (!kIsWeb && Platform.isAndroid) _openTelemetryView(isDarkMode),
          if (!kIsWeb && Platform.isAndroid) const SizedBox(width: 5),
          _openSelectSeasonView(),
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // kIsWeb ? is used to build code for web because Platform is not supported for web
          crossAxisAlignment: !kIsWeb
              ? Platform.isAndroid
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center
              : CrossAxisAlignment.center,
          children: [
            const Text(
              "RACE ROOM",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.4),
            ),
            Text(
              currentPage == 0
                  ? "Race Calendar"
                  : currentPage == 1
                      ? "Driver Standings"
                      : currentPage == 2
                          ? "Teams Standings"
                          : "Settings",
              style: TextStyle(color: AppColors.rootAppBarTitle, fontSize: 12.1, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: BottomBar(
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: AppColors.rootBottomBarIcon,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(bottomBarBorderRadius),
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        showIcon: false,
        width: MediaQuery.of(context).size.width * 0.923,
        barColor: AppColors.rootBottomBar,
        offset: 0.0,
        barAlignment: !kIsWeb && Platform.isIOS
            ? MediaQuery.of(context).size.height < 680
                ? Alignment(0, .985)
                : Alignment(0, 1.03)
            : Alignment(0, .998), //TabBar position set based on screen size
        iconHeight: 35,
        iconWidth: 35,
        reverse: false,
        body: (context, controller) => TabBarView(
          controller: _tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: [
            RacesScheduleView(
              controller: controller,
              onRefresh: _getRaceScheduleData,
              futureRaceScheduleData: futureRaceScheduleData,
              seasonYear: seasonYear,
            ),
            DriversStandingsView(
              controller: controller,
              onRefresh: _getDriverStandingsData,
              futureDriverStandingsData: futureDriverStandingsData,
            ),
            ConstructorStandingsView(
              onRefresh: _getConstructorStandingsData,
              futureConstructorStandingsData: futureConstructorStandingsData,
              controller: controller,
            ),
            const SettingsView(),
          ],
        ),
        // ClipRRect and Material are used to make the TabBar ripple effect rounded on external borders
        child: ClipRRect(
          borderRadius: BorderRadius.circular(bottomBarBorderRadius),
          child: Material(
            borderRadius: BorderRadius.circular(bottomBarBorderRadius),
            color: isDarkMode ? AppColors.rootTabBarDark : AppColors.rootTabBarLight,
            child: Obx(
              () => TabBar(
                controller: _tabController,
                indicatorWeight: 1.6,
                indicatorColor: isDarkMode ? AppColors.rootTabBarIndicatorDark : AppColors.rootTabBarIndicatorLight,
                tabs: [
                  Tab(
                    child: Text(tabTextSettingsController.shortTabText.value ? "RC" : "Races\nCalendar",
                        textAlign: TextAlign.center, style: tabTextSettingsController.shortTabText.value ? tabTextStyleShort : tabTextStyleFull),
                  ),
                  Tab(
                    child: Text(tabTextSettingsController.shortTabText.value ? "DS" : "Driver\nStandings",
                        textAlign: TextAlign.center, style: tabTextSettingsController.shortTabText.value ? tabTextStyleShort : tabTextStyleFull),
                  ),
                  Tab(
                    child: Text(tabTextSettingsController.shortTabText.value ? "TS" : "Teams\nStandings",
                        textAlign: TextAlign.center, style: tabTextSettingsController.shortTabText.value ? tabTextStyleShort : tabTextStyleFull),
                  ),
                  Tab(
                    child: Text(tabTextSettingsController.shortTabText.value ? "ST" : "Settings",
                        textAlign: TextAlign.center, style: tabTextSettingsController.shortTabText.value ? tabTextStyleShort : tabTextStyleFull),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _openSelectSeasonView() {
    return Padding(
      padding: EdgeInsets.only(right: 4.5, top: !kIsWeb && Platform.isAndroid ? 5 : 0),
      child: SizedBox(
        width: 82,
        height: 32,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            setState(() {
              isYearMenuOpen = true;
            });

            String selectedYear = await Get.to(
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 360),
              popGesture: false,
              () => SelectYearView(currentYearSelected: seasonYear),
            );

            if (selectedYear.isNotEmpty && selectedYear != seasonYear && selectedYear != "null") {
              setState(() {
                seasonYear = selectedYear;
              });
              _getAllData();
            }

            setState(() {
              isYearMenuOpen = false;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                seasonYear,
                style: TextStyle(color: AppColors.rootSeasonYearText, fontSize: 15.5, fontWeight: FontWeight.w500),
              ),
              Icon(isYearMenuOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.rootSeasonYearTextIcon, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _openTelemetryView(bool isDark) {
    return IconButton(
      icon: Image.asset(isDark ? "assets/images/telemetry-icon-dark.png" : "assets/images/telemetry-icon.png", width: 22),
      onPressed: () => Get.to(
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 250),
        popGesture: false,
        () => const TelemetryRequestView(),
      ),
    );
  }

  double _calculateTabFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set the tab font size based on the screen size
    if (screenWidth < 360) {
      return 8.0; // Extra small screens
    } else if (screenWidth < 400) {
      return 9.0; // Small screens
    } else {
      return 10.0; // Default font size
    }
  }
}
