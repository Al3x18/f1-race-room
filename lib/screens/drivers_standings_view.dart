import 'package:flutter/material.dart';
import 'package:race_room/utils/f1_teams_color.dart';
import 'package:race_room/model/driver_standings_model.dart';
import 'package:race_room/utils/safe_parse_points.dart';
import 'package:race_room/widgets/no_data_available_info.dart';
import 'package:race_room/widgets/position_container.dart';

class DriversStandingsView extends StatefulWidget {
  const DriversStandingsView({
    super.key,
    required this.controller,
    required this.futureDriverStandingsData,
    required this.onRefresh,
  });

  final ScrollController controller;
  final Future<MRDataDriverStandings?> futureDriverStandingsData;
  final void Function() onRefresh;

  @override
  State<DriversStandingsView> createState() => _DriversStandingsState();
}

class _DriversStandingsState extends State<DriversStandingsView> {
  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 14.4,
    );

    return FutureBuilder(
      future: widget.futureDriverStandingsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.standingsTable.standingsLists.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoDataAvailable(onRefresh: widget.onRefresh, infoLabel: "The standing for this season is not currently available.")
          );
        }

        final driverStandings = snapshot.data!.standingsTable.standingsLists[0].driverStandings;

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            widget.onRefresh();
            return;
          },
          child: ListView.builder(
            controller: widget.controller,
            itemCount: driverStandings.length,
            itemBuilder: (context, index) {
              final String roundNumber = snapshot.data!.standingsTable.round.toString();
              final String driverName = driverStandings[index].driver.givenName;
              final String driverSurname = driverStandings[index].driver.familyName;
              final String driverNumber = driverStandings[index].driver.permanentNumber.toString();
              final String driverTeam = driverStandings[index].constructors[0].name;
              final String driverPoints = driverStandings[index].points.toString();
              final String driverWins = driverStandings[index].wins.toString();
              final String driverPosition = driverStandings[index].position.toString();

              final String firstPilotPoints = driverStandings[0].points.toString();

              return Column(
                children: [
                  if (index == 0) const SizedBox(height: 5),
                  if (index == 0)
                    Text(
                      "Driver Standings after Round $roundNumber",
                      style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                    ),
                  ListTile(
                    leading: BuildPositionContainer(type: PositionContainerType.driverAndConstructorView, position: driverPosition),
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
                        SizedBox(width: MediaQuery.of(context).size.width * 0.017),
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
                          child: Text(
                              "(-${(safeParsePoints(firstPilotPoints) - safeParsePoints(driverPoints)) % 1 == 0 ? (safeParsePoints(firstPilotPoints) - safeParsePoints(driverPoints)).toInt() : (safeParsePoints(firstPilotPoints) - safeParsePoints(driverPoints)).toStringAsFixed(1)})"),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          driverTeam,
                          style: listTileStyle.copyWith(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.020),
                        Visibility(
                          visible: driverWins != "0",
                          child: Text(
                            "Wins: $driverWins",
                            style: listTileStyle.copyWith(fontSize: 12, color: const Color.fromARGB(255, 222, 179, 5), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
