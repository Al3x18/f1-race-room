import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:race_room/screens/telemetry_request_view.dart';
import 'package:race_room/utils/settings_controller.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/constructor_standings_model.dart';
import 'package:race_room/model/driver_standings_model.dart';
import 'package:race_room/model/race_schedule_model.dart';
import 'package:race_room/screens/constructor_standings_view.dart';
import 'package:race_room/screens/drivers_standings_view.dart';
import 'package:race_room/screens/races_schedule_view.dart';
import 'package:race_room/screens/select_year_view.dart';
import 'package:race_room/screens/settings_view.dart';

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

  final SettingsController settingsController = Get.find<SettingsController>();

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
    const double bottomBarBorderRadius = 18;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode ? [Colors.black, Colors.black] : [Colors.red, Colors.white],
            ),
          ),
        ),
        leading: Platform.isIOS || kIsWeb ? _openTelemetryView(isDarkMode) : null,
        actions: [
          if (Platform.isAndroid && !kIsWeb) _openTelemetryView(isDarkMode),
          if (Platform.isAndroid && !kIsWeb) const SizedBox(width: 5),
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
                  ? "Season Calendar"
                  : currentPage == 1
                      ? "Driver Standings"
                      : currentPage == 2
                          ? "Teams Standings"
                          : "Settings",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12.1, fontWeight: FontWeight.w600),
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
              color: Colors.white,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(bottomBarBorderRadius),
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        showIcon: false,
        width: MediaQuery.of(context).size.width * 0.9,
        barColor: Colors.black,
        offset: 0.0,
        barAlignment: Alignment.bottomCenter,
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
            color: isDarkMode ? const Color.fromARGB(255, 241, 240, 240) : Colors.black,
            child: TabBar(
              controller: _tabController,
              indicatorColor: isDarkMode ? Colors.black : Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.view_agenda_outlined,
                    color: isDarkMode ? Colors.black : Colors.white,
                    size: 28.5,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    isDarkMode ? "assets/images/ds-dark.png" : "assets/images/ds-light.png",
                    width: 31.5,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    isDarkMode ? "assets/images/ts-dark.png" : "assets/images/ts-light.png",
                    width: 31.5,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: isDarkMode ? Colors.black : Colors.white,
                    size: 28.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _openSelectSeasonView() {
    return Padding(
      padding: EdgeInsets.only(right: 4.5, top: Platform.isAndroid ? 5 : 0),
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
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15.5, fontWeight: FontWeight.w500),
              ),
              Icon(isYearMenuOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey.shade600, size: 30),
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
}
