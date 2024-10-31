import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Obx(() {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: settingsController.currentTheme.value == ThemeMode.dark ? [Colors.black, Colors.black] : [Colors.red, Colors.white],
              ),
            ),
          );
        }),
        actions: [
          SizedBox(
            width: 76,
            height: 34,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                String selectedYear = await Get.to(
                  transition: Transition.downToUp,
                  popGesture: false,
                  () => SelectYearView(currentYearSelected: seasonYear),
                );
                if (selectedYear.isNotEmpty && selectedYear != seasonYear && selectedYear != "null") {
                  setState(() {
                    seasonYear = selectedYear;
                  });
                  _getAllData();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    seasonYear,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14.2, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600)
                ],
              ),
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.refresh_outlined, size: 25, color: Colors.black),
          //   onPressed: () => _getAllData(),
          // ),
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Race Room",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              currentPage == 0
                  ? "Season Calendar"
                  : currentPage == 1
                      ? "Driver Standings"
                      : currentPage == 2
                          ? "Teams Standings"
                          : "Settings",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w600),
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
        borderRadius: BorderRadius.circular(26),
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
          borderRadius: BorderRadius.circular(26),
          child: Obx(() {
            return Material(
              borderRadius: BorderRadius.circular(26),
              color: settingsController.currentTheme.value == ThemeMode.dark ? const Color.fromARGB(255, 241, 240, 240) : Colors.black,
              child: TabBar(
                controller: _tabController,
                indicatorColor: settingsController.currentTheme.value == ThemeMode.dark ? Colors.black : Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.view_agenda_outlined,
                      color: settingsController.currentTheme.value == ThemeMode.dark ? Colors.black : Colors.white,
                      size: 25,
                    ),
                  ),
                  Tab(
                    icon: Image.asset(settingsController.currentTheme.value == ThemeMode.dark ? "assets/images/rhb.png" : "assets/images/rhw.png", width: 31),
                  ),
                  Tab(
                    icon: Image.asset(settingsController.currentTheme.value == ThemeMode.dark ? "assets/images/f1car.png" : "assets/images/f1car-white.png", width: 38),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: settingsController.currentTheme.value == ThemeMode.dark ? Colors.black : Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
