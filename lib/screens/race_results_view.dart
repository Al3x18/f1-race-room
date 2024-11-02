import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/screens/round_driver_s_view.dart';
import 'package:race_room/screens/round_teams_s_view.dart';
import 'package:race_room/utils/f1_teams_color.dart';
import 'package:race_room/model/race_results_model.dart';

class RaceResultsView extends StatefulWidget {
  const RaceResultsView({super.key, required this.seasonYear, required this.raceRound, required this.raceName});

  final String raceRound;
  final String raceName;
  final String seasonYear;

  @override
  State<RaceResultsView> createState() => _RaceResultsViewState();
}

class _RaceResultsViewState extends State<RaceResultsView> {
  late Future<MRDataRaceResults?> raceResults;

  @override
  void initState() {
    super.initState();
    raceResults = ApiService().fetchRaceResults(seasonYear: widget.seasonYear, round: widget.raceRound);
  }

  void _getResultsData() {
    raceResults = ApiService().fetchRaceResults(seasonYear: widget.seasonYear, round: widget.raceRound);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.raceName,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Text(
              "Race Results",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: raceResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final raceResults = snapshot.data!.raceTable.races[0].results;

          return Column(
            children: [
              ExpansionTile(
                title: Center(
                  child: Text(
                    "View standings after Round ${widget.raceRound}",
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.5)
                  ),
                ),
                collapsedIconColor: Colors.grey,
                iconColor: isDark ? Colors.white : Colors.black,
                collapsedTextColor: Colors.grey,
                textColor: isDark ? Colors.white : Colors.black,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Column(
                      children: [
                        BuildStandingsButton(
                            widget: widget,
                            isDark: isDark,
                            onPressed: () => Get.to(() => DriverSToRound(seasonYear: widget.seasonYear, round: widget.raceRound)),
                            buttonText: "Driver Standings",
                          ),
                        
                      const SizedBox(height: 8),
                         BuildStandingsButton(
                            widget: widget,
                            isDark: isDark,
                            onPressed: () => Get.to(() => TeamsSToRound(seasonYear: widget.seasonYear, round: widget.raceRound)),
                            buttonText: "Teams Standings",
                          ),
                      
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    _getResultsData();
                    return;
                  },
                  child: ListView.builder(
                      itemCount: raceResults.length,
                      itemBuilder: (context, index) {
                        final String driverPosition = raceResults[index].position;
                        final String driverName = raceResults[index].driver.givenName;
                        final String driverSurname = raceResults[index].driver.familyName;
                        final String driverNumber = raceResults[index].driver.permanentNumber;
                        final String driverTeam = raceResults[index].constructor.name;
                        final String status = raceResults[index].status;
                        final String grid = raceResults[index].grid;
                        final String laps = raceResults[index].laps;
                        final String points = raceResults[index].points;
                        final String fastestLap = raceResults[index].fastestLap?.time.time ?? "No Time Set";
                        final String raceTotalTime = raceResults[index].time?.time ?? "No Race Time";

                        return BuildDriverListTile(
                          driverPosition: driverPosition,
                          driverName: driverName,
                          driverSurname: driverSurname,
                          driverNumber: driverNumber,
                          driverTeam: driverTeam,
                          status: status,
                          grid: grid,
                          laps: laps,
                          points: points,
                          fastestLap: fastestLap,
                          raceTotalTime: raceTotalTime,
                        );
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class BuildStandingsButton extends StatelessWidget {
  const BuildStandingsButton({
    super.key,
    required this.widget,
    required this.isDark,
    required this.buttonText,
    required this.onPressed,
  });

  final RaceResultsView widget;
  final bool isDark;
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: isDark ? Colors.white : Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(buttonText, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    );
  }
}

class BuildDriverListTile extends StatelessWidget {
  const BuildDriverListTile({
    super.key,
    required this.driverPosition,
    required this.driverName,
    required this.driverSurname,
    required this.driverNumber,
    required this.driverTeam,
    required this.status,
    required this.grid,
    required this.laps,
    required this.points,
    required this.fastestLap,
    required this.raceTotalTime,
  });

  final String driverPosition;
  final String driverName;
  final String driverSurname;
  final String driverNumber;
  final String driverTeam;
  final String status;
  final String grid;
  final String laps;
  final String points;
  final String fastestLap;
  final String raceTotalTime;

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyleSubtitle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 12,
      color: Colors.grey,
    );

    return ListTile(
      leading: SizedBox(
        width: 38.5,
        child: Text(
          "P$driverPosition",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
        ),
      ),
      title: Row(
        children: [
          Text(driverName),
          const Text(" "),
          Text(
            driverSurname,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Text(
            driverNumber,
            style: TextStyle(fontWeight: FontWeight.bold, color: getTeamColor(driverTeam)),
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            driverTeam,
            style: listTileStyleSubtitle.copyWith(
              fontWeight: FontWeight.bold,
              color: getTeamColor(driverTeam),
            ),
          ),
          Row(
            children: [
              Text(
                "Grid: $grid",
                style: listTileStyleSubtitle,
              ),
              const Text(
                ", ",
                style: listTileStyleSubtitle,
              ),
              Text(
                "Laps: $laps",
                style: listTileStyleSubtitle,
              ),
            ],
          ),
          Text(
            "Points: $points",
            style: listTileStyleSubtitle,
          ),
          Row(
            children: [
              const Text(
                "Fastest Lap:",
                style: listTileStyleSubtitle,
              ),
              const SizedBox(width: 4),
              Text(
                fastestLap,
                style: listTileStyleSubtitle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 127, 21, 146),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Text(
        raceTotalTime == "No Race Time" ? status : raceTotalTime,
        style: const TextStyle(fontSize: 13.2, fontWeight: FontWeight.w400),
      ),
    );
  }
}
