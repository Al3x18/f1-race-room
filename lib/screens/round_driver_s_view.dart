import 'package:flutter/material.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/utils/f1_teams_color.dart';
import 'package:race_room/model/driver_standings_model.dart';

class DriverSToRound extends StatefulWidget {
  const DriverSToRound({
    super.key,
    required this.seasonYear,
    required this.round,
  });

  final String seasonYear;
  final String round;

  @override
  State<DriverSToRound> createState() => _DriverSToRoundState();
}

class _DriverSToRoundState extends State<DriverSToRound> {
  late Future<MRDataDriverStandings?> futureDriverStandingsData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    futureDriverStandingsData = ApiService().fetchDriverStandingsToRound(seasonYear: widget.seasonYear, round: widget.round);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Driver Standings", style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w600)),
            Text("After Round ${widget.round}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: FutureBuilder(
        future: futureDriverStandingsData,
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

          final driverStandings = snapshot.data!.standingsTable.standingsLists[0].driverStandings;

          return RefreshIndicator.adaptive(
            onRefresh: () async {
              _getData();
              return;
            },
            child: ListView.builder(
              itemCount: driverStandings.length,
              itemBuilder: (context, index) {
                //final String roundNumber = snapshot.data!.standingsTable.round.toString();
                final String driverName = driverStandings[index].driver.givenName;
                final String driverSurname = driverStandings[index].driver.familyName;
                final String driverNumber = driverStandings[index].driver.permanentNumber.toString();
                final String driverTeam = driverStandings[index].constructors[0].name;
                final String driverPoints = driverStandings[index].points.toString();
                final String driverWins = driverStandings[index].wins.toString();
                final String driverPosition = driverStandings[index].position.toString();

                final String firstPilotPoints = driverStandings[0].points.toString();

                int safeParsePoints(String points) {
                  try {
                    return int.parse(points);
                  } catch (e) {
                    return 0;
                  }
                }

                return ListTile(
                  leading: SizedBox(
                    width: 46,
                    child: Text(
                      driverPosition == "ND" ? "ND" : "#$driverPosition",
                      style: listTileStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(driverName, style: listTileStyle),
                      const Text(" "),
                      Text(
                        driverSurname,
                        style: listTileStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                      Text(
                        driverNumber == "No Data" ? "" : driverNumber,
                        style: listTileStyle.copyWith(fontSize: 12.5, fontWeight: FontWeight.bold, color: getTeamColor(driverTeam)),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$driverPoints pts.",
                        style: listTileStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: safeParsePoints(firstPilotPoints) - safeParsePoints(driverPoints) > 0,
                        child: Text("(-${safeParsePoints(firstPilotPoints) - safeParsePoints(driverPoints)})"),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        driverTeam,
                        style: listTileStyle.copyWith(fontSize: 12.5, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.022),
                      Visibility(
                        visible: driverWins != "0",
                        child: Text(
                          "Wins: $driverWins",
                          style: listTileStyle.copyWith(fontSize: 12.5, color: const Color.fromARGB(255, 222, 179, 5), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}