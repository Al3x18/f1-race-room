import 'package:flutter/material.dart';
import 'package:race_room/utils/f1_teams_color.dart';
import 'package:race_room/model/constructor_standings_model.dart';
import 'package:race_room/utils/safe_parse_points.dart';
import 'package:race_room/widgets/position_container.dart';

class ConstructorStandingsView extends StatefulWidget {
  const ConstructorStandingsView({
    super.key,
    required this.futureConstructorStandingsData,
    required this.controller,
    required this.onRefresh,
  });

  final Future<MRDataConstructorStandings?> futureConstructorStandingsData;
  final ScrollController controller;
  final void Function() onRefresh;

  @override
  State<ConstructorStandingsView> createState() => _ConstructorStandingsViewState();
}

class _ConstructorStandingsViewState extends State<ConstructorStandingsView> {
  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 14.5,
    );

    return FutureBuilder(
      future: widget.futureConstructorStandingsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData 
        || snapshot.data == null
        || snapshot.data!.standingsTable.standingsLists.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'No constructor standings available for this season',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final constructorStandings = snapshot.data!.standingsTable.standingsLists[0].constructorStandings;

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            widget.onRefresh();
            return;
          },
          child: ListView.builder(
            controller: widget.controller,
            itemCount: constructorStandings.length,
            itemBuilder: (context, index) {
              final String roundNumber = snapshot.data!.standingsTable.round.toString();
              final String constructorName = constructorStandings[index].constructor.name;
              final String constructorPoints = constructorStandings[index].points.toString();
              final String constructorWins = constructorStandings[index].wins.toString();
              final String constructorPosition = constructorStandings[index].position.toString();
              final String constructorNationality = constructorStandings[index].constructor.nationality;

              final String firstConstructorPoints = constructorStandings[0].points.toString();

              return Column(
                children: [
                  if (index == 0) const SizedBox(height: 5),
                  if (index == 0)
                    Text(
                      "Constructor Standings after Round $roundNumber",
                      style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                    ),
                  ListTile(
                    leading: BuildPositionContainer(type: PositionContainerType.driverAndConstructorView, position: constructorPosition),
                    title: Text(
                      constructorName,
                      style: listTileStyle.copyWith(fontWeight: FontWeight.bold, color: getTeamColor(constructorName)),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$constructorPoints pts.",
                          style: listTileStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Visibility(
                          visible: safeParsePoints(firstConstructorPoints) - safeParsePoints(constructorPoints) > 0,
                          child: Text(
                              "(-${(safeParsePoints(firstConstructorPoints) - safeParsePoints(constructorPoints)) % 1 == 0 
                              ? (safeParsePoints(firstConstructorPoints) - safeParsePoints(constructorPoints)).toInt() 
                              : (safeParsePoints(firstConstructorPoints) - safeParsePoints(constructorPoints)).toStringAsFixed(1)})",
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          constructorNationality,
                          style: listTileStyle.copyWith(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.022),
                        Visibility(
                          visible: constructorWins != "0",
                          child: Text(
                            "Wins: $constructorWins",
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
